module UsersHelper
  def find_user_photo(user)
    if user
      if user.photo?
        return cl_image_tag(user.photo.path, :width=>250, :height=>250, :crop=>"fill")
      elsif user.facebook_picture_url.nil? == false
        return image_tag(user.facebook_picture_url, class: "user-show-photo")
      end
    else
      return image_tag("user_avatar.png", class: "user-show-photo")
    end
  end

  def compute_total_divetime(user)
    total = 0
    user.dives.each { |dive| total += dive.bottom_time }
    total
  end

  def compute_longest_dive(user)
    user.dives.order(bottom_time: :DESC).first.bottom_time
  end

  def compute_deepest_dive(user)
    user.dives.order(max_depth: :DESC).first.max_depth.round
  end

  def compute_sightings(user)
    sightings = 0
    user.dives.each do |dive|
      sightings += dive.sightings.count
    end
    sightings
  end

  def compute_top3_divetypes(user)
    user.dives.group(:types).order('types DESC').limit(5).count(:id).reject { |k,v| k.nil? }
  end
end
