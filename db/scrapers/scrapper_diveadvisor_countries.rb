require "open-uri"
require "nokogiri"
require "json"
require 'net/http'

class ScrapperDiveadvisorCountries
  attr_reader :countries
  def initialize(view)
    @view = view
    countries = "http://diveadvisor.com/destinations"
    @nokodoc = Nokogiri::HTML(open(countries))
    @countries = []
  end

  def scrape
    @nokodoc.search('.div-destination-country-info').each do |country|
      begin
        id = country.attribute('id').text.scan(/\d{4}\z/)[0].to_i
      rescue
        puts "Error: no id"
      end
      begin
        name = country.css('li > a > .country-name').text
      rescue
        puts "Error: no name"
      end
      begin
        url = country.css('li > a').attribute('href').text
      rescue
        puts "Error: no url"
      end
      @countries << { id: id, name: name, url: url }
    end
  end
end
