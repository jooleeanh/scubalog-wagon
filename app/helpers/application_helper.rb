module ApplicationHelper

  def display_avatar(user, extra_class = "")
    if user
      if user.photo?
        return cl_image_tag(user.photo.path, :width=>36, :height=>36, :crop=>"fill", class: "avatar dropdown-toggle #{extra_class}", id: "navbar-wagon-menu", "data-toggle": "dropdown")
      elsif user.facebook_picture_url.nil? == false
        return image_tag(user.facebook_picture_url, class: "avatar dropdown-toggle #{extra_class}", id: "navbar-wagon-menu", "data-toggle": "dropdown")
      elsif user.image
        return image_tag(user.image, class: "avatar dropdown-toggle #{extra_class}", id: "navbar-wagon-menu", "data-toggle": "dropdown")
      end
    else
      return image_tag("user_avatar.png", class: "avatar dropdown-toggle #{extra_class}", id: "navbar-wagon-menu", "data-toggle": "dropdown")
    end
  end

  def display_avatar_big(user, extra_class = "")
    if user
      if user.photo?
        return cl_image_tag(user.photo.path, class: "avatar dropdown-toggle #{extra_class}", id: "navbar-wagon-menu", "data-toggle": "dropdown")
      elsif user.facebook_picture_url.nil? == false
        return image_tag(user.facebook_picture_url, class: "avatar dropdown-toggle #{extra_class}", id: "navbar-wagon-menu", "data-toggle": "dropdown")
      elsif user.image
        return image_tag(user.image, class: "avatar dropdown-toggle #{extra_class}", id: "navbar-wagon-menu", "data-toggle": "dropdown")
      end
    else
      return image_tag("user_avatar.png", class: "avatar dropdown-toggle #{extra_class}", id: "navbar-wagon-menu", "data-toggle": "dropdown")
    end
  end

  def display_name(user)
    if user
      return user.first_name
    end
  end

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

  def get_ju_flo_photos
    julian = User.find_by(last_name: "Honma")
    flo = User.find_by(last_name: "Bataille")
    active_record = []
    active_record << julian&.dives
    active_record << flo&.dives
    active_record.reject! { |dive| dive.nil? }
    photos = []
    active_record.each do |active|
      active.each do |dive|
        dive.photos.each { |photo| photos << photo.path }
      end
    end
    photos.reject! { |photo| photo.nil? }
    photos
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
