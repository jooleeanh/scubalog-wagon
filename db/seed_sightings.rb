class SeedSightings < BasicSeed

  def seed_sightings
    Dive.all.each do |dive|
      4.times do
        animal = Animal.all.sample
        sighting = dive.sightings.new(animal: animal)
        if sighting.save
          message(dive.id, "Dive at #{dive.divesite.name}", "had a sighting of", animal.name, "light_green")
        else
          error(sighting)
        end
      end
    end
  end
end
