require "open-uri"
require "json"
require 'net/http'

class ScrapperDiveadvisorSites
  def initialize(view, country)
    @view = view
    url = "http://diveadvisor.com/directory/getdiveplaces?ne_lat=33.332805&ne_lng=35.896244000000024&sw_lat=29.4906463&sw_lng=34.267386999999985&countryid=#{country[:id]}"
    @country_name = country[:name]
    uri = URI(url)
    response = Net::HTTP.get(uri)
    @json = JSON.parse(response)
    @attributes = {}
  end

  def scrape
    @json["ListSites"].each_with_index do |site, index|
      id = parse_id(site)
      country = parse_country(site)
      location = parse_location(site)
      name = parse_name(site)
      rating = parse_rating(site)
      position = parse_lat_lng(site)
      puts "#{id} - #{name}"
      @attributes[index] = {
        id: id,
        country: country,
        name: name,
        location: location,
        rating: rating,
        position: position
      }
    end
  end

  def store_json
    filepath = "files/diveadvisor_" + @country_name.downcase + Time.now.strftime('_%Y-%m-%d-%H-%M')
    Dir.mkdir("files") unless File.directory?("files")
    File.open(filepath + '.json', 'w') do |file|
      file.write(JSON.generate(@attributes))
    end
  end

  private

  def parse_id(site)
    id = nil
    begin
      id = site['siteID'].to_i
    rescue
      puts "Error: #{@country_name} - no id"
    end
    id
  end

  def parse_name(site)
    name = nil
    begin
      name = site['siteNickName']
    rescue
      puts "Error: #{@country_name} - no name"
    end
    name
  end
  def parse_location(site)
    location = nil
    begin
      location = site['siteLocation']
    rescue
      puts "Error: #{@country_name} - no location"
    end
    location
  end

  def parse_lat_lng(site)
    lat_lng = nil
    begin
      lat_lng = { lat: site['siteLatitide'].to_f, lng: site['siteLongitude'].to_f }
    rescue
      puts "Error: #{@country_name} - no lat_lng"
    end
    lat_lng
  end


  def parse_country(site)
    country = nil
    begin
      country = site['siteCountryName']
    rescue
      puts "Error: #{@country_name} - no country"
    end
    country
  end

  def parse_rating(site)
    rating = 0
    begin
      rating += 1 if site['GetRatingStarClass1'] == "icon star-fill"
      rating += 1 if site['GetRatingStarClass2'] == "icon star-fill"
      rating += 1 if site['GetRatingStarClass3'] == "icon star-fill"
      rating += 1 if site['GetRatingStarClass4'] == "icon star-fill"
      rating += 1 if site['GetRatingStarClass5'] == "icon star-fill"
    rescue
      puts "Error: #{@country_name} - no rating"
    end
    rating
  end
end
