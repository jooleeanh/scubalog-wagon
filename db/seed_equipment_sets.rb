class SeedEquipmentSets < BasicSeed

  def seed_equipment_sets
    seed_basic_set
  end

  def seed_basic_set
    noun = "Basic Equipment Set"
    User.all.each do |user|
      if user.equipment_sets.first&.mask == "Aqualung - Sphera"
        message(user.id, user.first_name, "already has", noun, "light_red")
      else
        set = user.equipment_sets.new(basic_set)
        if set.save
          message(user.id, user.first_name, "got", noun, "light_green")
        else
          error(user)
        end
      end
    end
  end

  def basic_set
    {
      mask: "Aqualung - Sphera",
      snorkel: "Atomic - Ultradry",
      fins: "Apeks - Rockets",
      wetsuit: "Hollis - Neotek",
      computer: "Suunto D6i",
      bcd: "Oceanic - Jetpack",
      regulator: "Apeks - XTX50",
      weight: 4
    }
  end
end
