class DeleteSeed < BasicSeed

  def delete_all?
    answers = {}
    stylize("--- DELETING SEED ---".light_red)
    puts "\n"
    MODELS.each do |model_section|
      dependent_models = get_names_in(model_section[1], []).join(", ")
      puts "Dependent: ".light_black + "#{dependent_models}".yellow
      print "- [y/n] ".light_black + "DELETE ".light_red + "#{model_section[0].name.pluralize}? ".light_yellow
      print " > "
      answer = STDIN.gets.chomp
      answers[model_section[0].name.downcase] = (answer.downcase == "y")
    end
    puts ""
    MODELS.each do |model_section|
      if answers[model_section[0].name.downcase]
        stylize("#{model_section[0].count} #{model_section[0].name.downcase.pluralize} deleted.".light_red)
        get_size_of(model_section[1])
        puts ""
        model_section[0].destroy_all
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
end
