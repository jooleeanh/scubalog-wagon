class BasicSeed

  def stylize(string)
    string.each_char { |chr| print chr; sleep 0.02 }
    puts ""
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
