require 'pry-byebug'
require_relative 'scrapers/suunto/suunto_device'
require_relative 'scrapers/suunto/suunto_freediving'
require_relative 'scrapers/suunto/suunto_scuba'

class SeedComputerDives
  def initialize
    @filedir = "/home/julian/code/jooleeanh/scubalog/db/scrapers/suunto/suunto_logs/"
  end

  def seed_computer_dive
    user = User.where(first_name: "Julian").first
    Dir.glob((@filedir + "*.sml")) do |file|
      document = create_noko_xml(file)
      if document.root.css('Header DiveMode').text == "Free"
        puts "Skip - Freedive file"
        # device = SuuntoDevice.new(document)
        # @log_hash = SuuntoFreediving.new(dive, device).parse
      else
        device = SuuntoDevice.new(document)
        data = SuuntoScuba.new(document, device).parse
        f_data = reformat_computer_data(data)
        dive = create_dive(f_data, user)
        if dive.save
          puts "Dive saved"
        end
      end
    end
  end

  def create_noko_xml(filepath)
    file = File.open(filepath)
    document = Nokogiri::XML(file) do |config|
      config.options = Nokogiri::XML::ParseOptions::STRICT | Nokogiri::XML::ParseOptions::NONET
    end
    document
  end

  def reformat_computer_data(data)
    f_data = {}
    f_data[:datetime] = Time.parse(data[:date_time])
    begin
      f_data[:types] = "Deep" if (data[:max_depth].to_i > 18)
    rescue
      puts "Error: no max-depth??!"
    end
    begin
      f_data[:bottom_time] = data[:samples].last[:time] / 60
    rescue
      puts "Error: no samples"
    end
    pressures = array_all(data[:samples], :tank_pressure)
    air = reformat_pressures(pressures)
    f_data[:start_air] = air[:start_air]
    f_data[:end_air] = air[:end_air]
    f_data[:max_depth] = data[:max_depth].to_f
    f_data[:avg_depth] = data[:avg_depth].to_f
    temps = array_all(data[:samples], :temperature)
    f_data[:min_temp] = (temps.min - 273.15).round(2)
    f_data[:max_temp] = (temps.max - 273.15).round(2)
    f_data
  end

  def reformat_pressures(pressures)
    first_pressure = (pressures&.first&.fdiv(100_000))&.round
    if first_pressure == 0
      start_air = nil
    else
      start_air = first_pressure.to_i
    end
    last_pressure = (pressures&.last&.fdiv(100_000))&.round
    if last_pressure == 0
      end_air = nil
    else
      end_air = last_pressure.to_i
    end
    {start_air: start_air, end_air: end_air}
  end

  def array_all(samples, symbol)
    array = samples.map { |_, v| v[symbol].to_i }
    array.reject! { |object| object.blank? }
    array
  end

  def create_dive(f_data, user)
    dive = Dive.new(
    datetime: f_data[:datetime],
    types: f_data[:types],
    tank_size: 80,
    bottom_time: f_data[:bottom_time],
    start_air: f_data[:start_air],
    end_air: f_data[:end_air],
    max_depth: f_data[:max_depth],
    avg_depth: f_data[:avg_depth],
    min_temp: f_data[:min_temp],
    max_temp: f_data[:max_temp],
    comments: nil,
    enjoyment: nil,
    visibility: nil,
    polygon: nil,
    )
    dive.divesite = Divesite.all.first
    dive.user = user
    dive
  end
end
