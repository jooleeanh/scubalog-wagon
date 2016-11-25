
require "json"
class OceanaPhotos

  def parse_animals
    JSON.parse(File.read("db/data/animals_225_oceana.json"))
  end

  def download_pictures
    json_doc = parse_animals
    json_doc.each do |key, category|
      category["creatures"].each do |k, animal|
        name = animal["name"].downcase.gsub(" ", "_").gsub("'", "-")
        image_url = animal["image_url"]
        `curl #{image_url} > app/assets/images/animals/#{name}.jpg`
      end
    end
  end
end

prog = OceanaPhotos.new
prog.download_pictures
