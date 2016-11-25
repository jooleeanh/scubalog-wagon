require 'nokogiri'
require_relative 'suunto_device'
require_relative 'suunto_freediving'
require_relative 'suunto_scuba'
require_relative 'scrapper_diveadvisor_sites'
require_relative 'scrapper_diveadvisor_countries'

class Controller
  def initialize(view)
    @view = view
    @log_hash = {}
  end

  def parse_freediving_example
    # TODO:
    document = freediving_example
    device = SuuntoDevice.new(document)
    @log_hash = SuuntoFreediving.new(document, device).parse
    @view.parsing_done
  end

  def parse_scuba_example
    # TODO:
    document = scuba_example
    device = SuuntoDevice.new(document)
    @log_hash = SuuntoScuba.new(document, device).parse
    @view.parsing_done
  end

  def scrape_diveadvisor_countries
    @diveadvisor_countries = ScrapperDiveadvisorCountries.new(@view)
    @diveadvisor_countries.scrape
    @countries = @diveadvisor_countries.countries
    @view.print_countries(@countries)
    @view.press_enter
  end

  def scrape_diveadvisor_country
    begin
      @view.print_countries(@countries)
      index = @view.get_index
      country = @countries.find { |e| e[:id] == index }
      @diveadvisor = ScrapperDiveadvisorSites.new(@view, country)
      @diveadvisor.scrape
      @diveadvisor.store_json
      @view.parsing_done
      @view.press_enter
    rescue
      puts "Please scrape countries first"
      @view.press_enter
    end
  end

  def scrape_diveadvisor_all
    @countries.each do |country|
      @diveadvisor = ScrapperDiveadvisorSites.new(@view, country)
      @diveadvisor.scrape
      @diveadvisor.store_json
      @view.parsing_done
    end
    @view.press_enter
  end

  def parse_all
    # TODO:
    @view.not_implemented
  end

  def view_parsed_example
    # TODO:
    @view.print_hash(@log_hash)
  end

  def reformat_hash
    # TODO:
    @view.not_implemented
  end

  def freediving_example
    filepath = 'suunto_logs/51670658-2016-01-21T14_53_59-0.sml'
    file = File.open(filepath)
    document = Nokogiri::XML(file) do |config|
      config.options = Nokogiri::XML::ParseOptions::STRICT | Nokogiri::XML::ParseOptions::NONET
    end
    document
  end

  def scuba_example
    filepath = 'suunto_logs/51670658-2016-08-06T07_33_55-0.sml'
    file = File.open(filepath)
    document = Nokogiri::XML(file) do |config|
      config.options = Nokogiri::XML::ParseOptions::STRICT | Nokogiri::XML::ParseOptions::NONET
    end
    document
  end
end
