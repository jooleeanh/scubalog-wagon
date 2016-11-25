class SeedAnimals < BasicSeed

  def parse_animals
    JSON.parse(File.read("db/data/animals_225_oceana.json"))
  end

  def seed_animals
    json_doc = parse_animals
    json_doc.each do |key, category|
      category["creatures"].each do |k, animal|
        new_animal = Animal.new(
        name: animal["name"],
        image_url: "animals/" + animal["name"].downcase.gsub(" ", "_").gsub("'", "-"),
        )
        if new_animal.save
          puts "#{animal["name"]}".light_green
        else
          puts "#{new_animal.errors.messages}".light_red
        end
      end
    end
  end
end
