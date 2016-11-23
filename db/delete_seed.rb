class DeleteSeed < BasicSeed

  MODELS = [
    [User, [Participation, Dive, [EquipmentSet, Buddy, DataPoint, Sighting]]],
    [Divesite, [Event]],
    [Animal, [Sighting]],
    [Event, [Participation]]
  ]

  def delete_all?
    answers = {}
    stylize("--- DELETING SEED ---".light_red)
    puts "\n"
    MODELS.each do |model|
      dependent_models = get_names_in(model[1], []).join(", ")
      puts "Dependent: ".light_black + "#{dependent_models}".yellow
      print "- [y/n] ".light_black + "DELETE ".light_red + "#{model[0].name.pluralize}? ".light_yellow
      print " > "
      answer = STDIN.gets.chomp
      answers[model[0].name.downcase] = (answer.downcase == "y")
    end
    puts ""
    MODELS.each do |model|
      if answers[model[0].name.downcase]
        stylize("#{model[0].count} #{model[0].name.downcase.pluralize} deleted.".light_red)
        get_size_of(model[1])
        puts ""
        model[0].destroy_all
      end
    end
  end

  def get_names_in(array, results)
    array.each do |e|
      if e.class == Array
        get_names_in(e, results)
      else
        results << e.name.pluralize
      end
    end
    results
  end

  def get_size_of(array)
    array.each do |sub_model|
      if sub_model.class == Array
        print "  "
        get_size_of(sub_model)
      else
        puts "- #{sub_model.count} #{sub_model.name.pluralize} deleted.".red
        sleep(0.015)
      end
    end
  end
end
