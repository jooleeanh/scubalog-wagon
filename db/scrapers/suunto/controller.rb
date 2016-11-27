require 'nokogiri'
require_relative 'suunto_device'
require_relative 'suunto_freediving'
require_relative 'suunto_scuba'

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
    filename = "51670658-2016-01-21T14_53_59-0.sml"
    filedir = "/home/julian/code/jooleeanh/scubalog/db/scrapers/suunto/suunto_logs/"
    filepath = filedir + filename
    file = File.open(filepath)
    document = Nokogiri::XML(file) do |config|
      config.options = Nokogiri::XML::ParseOptions::STRICT | Nokogiri::XML::ParseOptions::NONET
    end
    document
  end

  def scuba_example
    filedir = "/home/julian/code/jooleeanh/scubalog/db/scrapers/suunto/suunto_logs/"
    filename = "51670658-2016-08-06T07_33_55-0.sml"
    filepath = filedir + filename
    file = File.open(filepath)
    document = Nokogiri::XML(file) do |config|
      config.options = Nokogiri::XML::ParseOptions::STRICT | Nokogiri::XML::ParseOptions::NONET
    end
    document
  end
end
