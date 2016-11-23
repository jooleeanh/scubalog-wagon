class SeedEquipmentSets < BasicSeed

  def seed_equipment_sets
    seed_basic_set
  end

  def seed_basic_set
    User.all.each do |user|
      if user.equipment_sets.first&.mask == "Aqualung - Sphera"
        message(user, "already has")
      else
        set = user.equipment_sets.new(basic_set)
        if set.save
          message(user, "got")
        else
          puts "#{set.errors.full_messages}".light_red
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

  def message(user, status)
    case status
    when "already got" then status = status.light_red
    when "got" then status = status.light_green
    end
    print "#{user.id} - ".light_black
    print "#{user.first_name.capitalize}".light_yellow
    print " #{status} "
    puts "'Basic Equipment Set'".blue
  end
end
