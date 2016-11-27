require_relative 'suunto_device'

class SuuntoScuba
  def initialize(document, device)
    @document = document
    @device = device
  end

  def parse
    hash = {}
    hash.merge(parse_header(hash))
    hash.merge(@device.parse(hash))
    hash.merge(parse_samples(hash))
  end

  def parse_header(hash)
    @document.root.css('Header').each do |tag|
      hash[:date_time] = tag.css('DateTime').text
      hash[:duration] = tag.css('Duration').text
      hash[:max_depth] = tag.css('Max').text
      hash[:avg_depth] = tag.css('Avg').text
      hash[:dive_mode] = tag.css('DiveMode').text
      hash[:conservatism] = tag.css('Conservatism').text
      hash[:altitude] = tag.css('Altitude').text
      hash[:surface_time] = tag.css('SurfaceTime').text
      hash[:number_in_series] = tag.css('NumberInSeries').text
      hash[:surface_pressure] = tag.css('SurfacePressure').text
      hash[:algorithm] = tag.css('Algorithm').text
      hash[:gas_type] = tag.css('State').text
      hash[:oxygen_content] = tag.css('Oxygen').text
      hash[:used_pressure] = tag.css('UsedPressure').text
      start_tissues = {}
      end_tissues = {}
      hash[:start_tissues] = parse_tissues(tag, start_tissues)
      hash[:end_tissues] = parse_tissues(tag, end_tissues)
      hash[:sample_interval] = tag.css('SampleInterval').text
    end
    hash
  end

  def parse_samples(hash)
    @document.root.css('Sample').each_with_index do |tag, index|
      sample = {}
      time = tag.css('Time').text
      depth = tag.css('Depth').text
      temperature = tag.css('Temperature').text
      tank_pressure = tag.css('TankPressure').text
      sample[:time] = time
      sample[:depth] = depth
      sample[:temperature] = temperature
      sample[:tank_pressure] = tank_pressure
      hash["sample_#{index.to_s.rjust(3, "0")}".to_sym] = sample
    end
    hash
  end

  def parse_tissues(tag, hash)
    hash = {}
    tag.css('StartTissue').each do |stat|
      hash[:cns] = stat.css('CNS').text
      hash[:otu] = stat.css('OTU').text
      hash[:olf] = stat.css('OLF').text
      nitrogen_loading = {}
      stat.css('Pressure').each_with_index do |nitro, index|
        nitrogen_loading[index] = nitro.text
      end
      hash[:nitrogen_loading] = nitrogen_loading
      hash[:rgbm_nitrogen] = stat.css('RgbmNitrogen').text
    end
    hash
  end
end

# device_parser = SuuntoDevice.new
# scuba_parser = SuuntoScuba.new(document, device_parser)
# hash = scuba_parser.parse
# hash.each do |key, value|
#   puts "#{key} - #{value}"
# end
