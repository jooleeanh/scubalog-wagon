class BasicSeed
  def stylize(string)
    string.each_char { |chr| print chr; sleep 0.02 }
    puts ""
  end
end
