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
end
