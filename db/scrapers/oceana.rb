require "open-uri"
require "nokogiri"
require "json"
require "pry-byebug"
require "colorize"

class Oceana
  attr_reader :oceana, :url

  def initialize
    @url = "http://oceana.org"
    url = @url + "/marine-life"
    @noko_categories = Nokogiri::HTML(open(url))
    @oceana = {}
  end

  def scrape_categories
    @noko_categories.search('.animal-tile').each_with_index do |c, i|
      category = {}
      category[:id] = i
      category[:url] = c.css('a').attribute('href').text
      category[:name] = c.css('h1').text
      category[:image_url] = c.css('img').attribute("src").text
      @oceana[i] = category
      puts "#{@oceana[i][:name]}".light_blue
    end
    puts "#{@oceana.count} categories found.".light_green
  end

  def scrape_category(id, noko_category)
    @oceana[id][:creatures] = {}
    @oceana[id][:description] = noko_category.css('field-content > p:nth-child(2)').text
    noko_category.search('.node-encyclopedia-entry').each_with_index do |s, i|
      creature = {}
      creature[:url] = s.css('.overlay >  a').attribute('href').text
      creature[:name] = s.css('h1').text
      @oceana[id][:creatures][i] = creature
      puts "Category - #{@oceana[id][:name]} - " + "#{creature[:name]}".light_blue
    end
    puts "Category - #{@oceana[id][:name]} - #{@oceana[id].count} creatures found".light_green
  end

  def scrape_creature(id, c_id, noko_creature)
    creature = @oceana[id][:creatures][c_id]

    creature[:scientific_name] = noko_creature.css('.subpage-header-inner > .subname').text
    creature[:description_short] = noko_creature.css('.subpage-header-inner > p:nth-child(5)').text

    card = noko_creature.css('.animal-details-block')
    creature[:image_url] = card.css('div div a').attribute('href').text
    creature[:image_credit] = card.css('figcaption').text

    details = card.css('.animal-details-side')
    keys = details.css('h2').map { |h2| h2.text }
    values = details.css('p').map { |pgs| pgs.text }
    values.each_with_index do |v, i|
      creature[keys[i].to_sym] = v
    end
    creature[:description_full] = noko_creature.css('.animal-secondary p:not(:last-child)').text
    @oceana[id][c_id]
    puts "Category - #{@oceana[id][:name]} - " + "#{creature[:name]}".light_green
  end

  def store_json
    filepath = "files/oceana" + Time.now.strftime('_%Y-%m-%d-%H-%M')
    Dir.mkdir("files") unless File.directory?("files")
    File.open(filepath + '.json', 'w') do |file|
      file.write(JSON.generate(@oceana))
    end
  end
end

instance = Oceana.new
# Get the 8 categories
instance.scrape_categories
# Get each subcategory of the 8 categories
instance.oceana.each do |id, category|
  url = instance.url + category[:url]
  noko_category = Nokogiri::HTML(open(url))
  instance.scrape_category(id, noko_category)
end
# Get each creature for each subcategory of category
instance.oceana.each do |id, category|
  category[:creatures].each do |c_id, creature|
    url = instance.url + creature[:url]
    noko_creature = Nokogiri::HTML(open(url))
    instance.scrape_creature(id, c_id, noko_creature)
  end
end
binding.pry
instance.store_json
