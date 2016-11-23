class BasicSeed

  def stylize(string)
    string.each_char { |chr| print chr; sleep 0.02 }
    puts ""
  end

  def get_size_of(array, action = "")
    array.each do |sub_model|
      if sub_model.class == Array
        print "  "
        get_size_of(sub_model, action)
      else
        message = "- #{sub_model.count} #{sub_model.name.pluralize} #{action}"
        case action
        when "" then puts message.light_yellow
        when "deleted" then puts message.red
        when "created" then puts message.green
        end
        sleep(0.018)
      end
    end
  end

  def message(id, name, verb, noun, color)
    case color
    when "light_red" then verb = verb.light_red
    when "light_green" then verb = verb.light_green
    end
    print "#{id} - ".light_black
    print "#{name.capitalize}".light_yellow
    print " #{verb} "
    puts "'#{noun}'".blue
  end

  def error(model)
    puts "#{model.errors.full_messages}".light_red
  end
end
