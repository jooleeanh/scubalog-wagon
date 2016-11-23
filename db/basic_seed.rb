class BasicSeed

  def stylize(string)
    string.each_char { |chr| print chr; sleep 0.02 }
    puts ""
  end

  def get_size_of(array, action = "")
    array.each do |sub_model|
      if sub_model.class == Array
        print "  "
        get_size_of(sub_model)
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
end
