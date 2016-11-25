module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    devise_mapping.to
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def date_short(datetime)
    datetime.strftime("%b. %d, %Y")
  end

  def date_long(datetime)
    datetime.strftime("%A, %B %d, %Y")
  end

  def time_long(datetime)
    datetime.strftime("%k:%M")
  end

  def split_animals(sightings)
    if sightings.any?
      animals = sightings.map do |sighting|
        sighting.animal
      end
      splitted_animals = animals.each_slice( (animals.size/2.0).round ).to_a
    end
    splitted_animals
  end
end


# Date (Year, Month, Day):
#   %Y - Year with century if provided, will pad result at least 4 digits.
#           -0001, 0000, 1995, 2009, 14292, etc.
#   %C - year / 100 (rounded down such as 20 in 2009)
#   %y - year % 100 (00..99)
#
#   %m - Month of the year, zero-padded (01..12)
#           %_m  blank-padded ( 1..12)
#           %-m  no-padded (1..12)
#   %B - The full month name (``January'')
#           %^B  uppercased (``JANUARY'')
#   %b - The abbreviated month name (``Jan'')
#           %^b  uppercased (``JAN'')
#   %h - Equivalent to %b
#
#   %d - Day of the month, zero-padded (01..31)
#           %-d  no-padded (1..31)
#   %e - Day of the month, blank-padded ( 1..31)
#
#   %j - Day of the year (001..366)
#
# Time (Hour, Minute, Second, Subsecond):
#   %H - Hour of the day, 24-hour clock, zero-padded (00..23)
#   %k - Hour of the day, 24-hour clock, blank-padded ( 0..23)
#   %I - Hour of the day, 12-hour clock, zero-padded (01..12)
#   %l - Hour of the day, 12-hour clock, blank-padded ( 1..12)
#   %P - Meridian indicator, lowercase (``am'' or ``pm'')
#   %p - Meridian indicator, uppercase (``AM'' or ``PM'')
#
#   %M - Minute of the hour (00..59)
#
#   %S - Second of the minute (00..60)
#
# Weekday:
#   %A - The full weekday name (``Sunday'')
#           %^A  uppercased (``SUNDAY'')
#   %a - The abbreviated name (``Sun'')
#           %^a  uppercased (``SUN'')
#   %u - Day of the week (Monday is 1, 1..7)
#   %w - Day of the week (Sunday is 0, 0..6)
