# frozen_string_literal: true

class SpotifyRepository
  API_KEY = Rails.application.credentials.spotify[:client_id]
  API_SECRET_KEY = Rails.application.credentilals.spotify[:client_secret]
  AUTH_URI = "https://accounts.spotify.com/api/token"
  SEARCH_URI = "https://api.spotify.com/v1/search?"
  AUTH_GRANT_TYPE = { "grant_type" => "client_credentials" }

  def search(params)
    
  end
end
