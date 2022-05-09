module UsersHelper
  def encode_image_b64(raw_image)
    Base64.strict_encode64(raw_image)
  end
end
