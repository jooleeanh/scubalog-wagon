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

  def cumulative_line_chart_data(user)
    sum = 0
    data = user.dives.group_by_day(:datetime).count
    data = data.to_a.sort { |k, v| k[0] <=> v[0] }
    data = data.map { |k, v| { k => (sum += v) } }
    data = data.reduce({}, :merge)
  end

  def compute_total_divetime(user)
    total = 0
    user.dives.each { |dive| total += dive.bottom_time }
    if total > (60 * 24)
      pluralize((total.fdiv(60 * 24)).round(1), "day")
    elsif total > 60
      pluralize((total.fdiv(60).round(1)), "hour")
    else
      total.to_s + " min"
    end
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
