require 'pry-byebug'
require_relative 'scrapers/suunto/suunto_device'
require_relative 'scrapers/suunto/suunto_freediving'
require_relative 'scrapers/suunto/suunto_scuba'

class SeedComputerDives < BasicSeed
  def initialize
    @filedir = "/home/julian/code/jooleeanh/scubalog/db/scrapers/suunto/suunto_logs/"
    @dives_with_dps = []
  end

  def seed_computer_dive
    custom_users = User.where.not(facebook_picture_url: nil)
    dive_count = 0
    freedive_files = 0
    count = 0
    limit = custom_users.count * 8
    catch :reach_limit do
      Dir.glob((@filedir + "*.sml")) do |file|
      throw :reach_limit if count > limit
      document = create_noko_xml(file)
      if document.root.css('Header DiveMode').text == "Free"
        freedive_files += 1
        # device = SuuntoDevice.new(document)
        # @log_hash = SuuntoFreediving.new(dive, device).parse
      else
        device = SuuntoDevice.new(document)
        data = SuuntoScuba.new(document, device).parse
        f_data = reformat_computer_data(data)
        dive = create_dive(f_data, custom_users.sample)
        if dive.save
          dive_count += 1
        end
        unless f_data[:samples].count > 5
          create_data_points(dive, f_data[:samples])
        end
        count += 1
      end
    end
    end
    puts "#{freedive_files} freedive files ignored.".yellow
    puts "#{dive_count} dives created".light_yellow
    examples = @dives_with_dps.first(3).join(", #")
    puts "Examples: Dives ##{examples}".light_black
  end

  def create_data_points(dive, samples)
    samples.each do |_, sample|
      air = sample[:tank_pressure] unless sample[:tank_pressure] == 0
      dp = DataPoint.new(
      dive: dive,
      time: sample[:time],
      depth: sample[:depth],
      temp: sample[:temperature],
      air: air
      )
      if dp.save
        @dives_with_dps << dive.id
      else
        puts dp.errors.full_messages
      end
    end
    puts "Dive #{dive.id} was created with #{samples.count} data points".light_green
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
    f_data[:types] = "Deep" if (data[:max_depth].to_i > 18)
    begin
      f_data[:bottom_time] = data[:samples].last[:time] / 60
    rescue
    end
    f_samples = reformat_samples(data[:samples])
    pressures = array_all(f_samples, :tank_pressure)
    pressures.map! { |pressure| pressure = nil if pressure == 0 }
    f_data[:start_air] = pressures.first
    f_data[:end_air] = pressures.last
    f_data[:max_depth] = data[:max_depth].to_f
    f_data[:avg_depth] = data[:avg_depth].to_f
    temps = array_all(f_samples, :temperature)
    f_data[:min_temp] = temps.min
    f_data[:max_temp] = temps.max
    f_data[:samples] = f_samples
    f_data
  end

  def reformat_samples(samples)
    f_samples = {}
    samples.each_with_index do |(_, sample), i|
      new_sample = {}
      new_sample[:time] = sample[:time]
      new_sample[:depth] = sample[:depth].to_f
      new_sample[:temperature] = sample[:temperature].to_f - 273.15
      new_sample[:tank_pressure] = sample[:tank_pressure].to_i.fdiv(100_000)
      f_samples[i] = new_sample
    end
    f_samples
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
    enjoyment: rand(1...5),
    visibility: rand(2...6)*5,
    polygon: nil,
    )
    dive.divesite = Divesite.all.first
    dive.user = user
    dive
  end
end
