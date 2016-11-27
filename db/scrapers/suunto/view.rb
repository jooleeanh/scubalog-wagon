require 'colorize'

class View
  attr_reader :choices
  def initialize
    @choices = [
      "Exit\n".light_yellow,
      "Parse a Suunto SML Freediving file",
      "Parse a Suunto SML Scuba file",
      "Parse entire folder",
      "View parsed example",
      "Reformat parsed hash",
    ]
  end

  def greeting
    print `clear`
    puts "What would you like to do?\n\n"
  end

  def print_choices
    @choices.each_with_index do |choice, index|
      puts (index).to_s.red + " - #{choice}"
    end
  end

  def not_implemented
    print `clear`
    puts "\nNot yet implemented".light_red
    press_enter
  end

  def parsing_done
    puts "\nParsing done!".green
  end

  def print_hash(hash)
    print `clear`
    hash.each do |key, value|
      puts "{" + "#{key}:".light_green + " #{value}}"
    end
    press_enter
  end

  def print_countries(array)
    array.each do |item|
      puts "#{item[:id]} - #{item[:name]} (#{item[:url]})"
      sleep(0.001)
    end
  end

  def get_index
    print "\nChoose index > ".light_cyan
    gets.chomp.to_i
  end

  def press_enter
    print "\nPress enter to go back to menu > ".light_cyan
    gets.chomp
  end
end
