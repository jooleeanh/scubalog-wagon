require_relative 'suunto_device'

# filepath = 'suunto_logs/51670658-2016-01-21T14_53_59-0.sml'
# file = File.open(filepath)
# document = Nokogiri::XML(file) do |config|
#   config.options = Nokogiri::XML::ParseOptions::STRICT | Nokogiri::XML::ParseOptions::NONET
# end

class SuuntoFreediving
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

  private

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
      hash[:surface_pressure] = tag.css('SurfacePressure').text
      hash[:sample_interval] = tag.css('SampleInterval').text
    end
    hash
  end

  def parse_device(hash)
    @document.root.css('Device').each do |tag|
      hash[:name] = tag.css('Name').text
      hash[:serial_number] = tag.css('SerialNumber').text
      hash[:sw] = tag.css('SW').text
      hash[:hw] = tag.css('HW').text
      hash[:bsl] = tag.css('BSL').text
    end
    hash
  end

  def parse_samples(hash)
    @document.root.css('Sample').each_with_index do |tag, index|
      sample = {}
      time = tag.css('Time').text
      depth = tag.css('Depth').text
      temperature = tag.css('Temperature').text
      sample[:time] = time
      sample[:depth] = depth
      sample[:temperature] = temperature
      hash["sample_#{index.to_s.rjust(3, "0")}".to_sym] = sample
    end
    hash
  end
end

# device_parser = SuuntoDevice.new
# freediving_parser = SuuntoFreediving.new(document, device_parser)
# hash = freediving_parser.parse
# hash.each do |key, value|
#   puts "#{key} - #{value}"
# end
