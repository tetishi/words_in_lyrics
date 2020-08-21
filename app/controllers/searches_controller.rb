# frozen_string_literal: true

class SearchesController < ApplicationController
  def index
  end

  def show
    # どの単語でも
    # words = params[:q]
    # search_words = "q=#{words}"

    params = URI.encode_www_form({search: "q=Kendrick%20Lamar"})
    token = "OWOAJA6tyCbNQKQBi3NUZkkY_xdtdZX3ZNTC-mXb_4g3Gwz7gGjqPprtaUs7VZNB"
    uri = URI.parse("https://api.genius.com/search?#{params}")
    @query = uri.query

    response = Net::HTTP.start(uri.host, uri.port) do |http|
      http.open_timeout = 5
      http.read_timeout = 10
      http.get(uri.request_uri)
    end
　　# ここは動いてる

    req = Net::HTTP::Get.new(uri.request_uri)
    req["Authorization"] = "Bearer #{token}"
    
    # Authorizationになにも入っていないから入れる

    req = http.request(req)

    binding.irb

    begin
      case response
      when Net::HTTPSuccess
        @result = JSON.parse(response.body)
        @search = @result["results"][0]["search"]
        @full_title = @result["results"][0]["full_title"]
        @header_image_thumbnail_url = @result["results"][0]["@header_image_thumbnail_url"]
        @header_image_url = @result["results"][0]["header_image_url"]
        @song_art_image_thumbnail_url = @result["results"][0]["song_art_image_thumbnail_url"]
        @song_art_image_url = @result["results"][0]["song_art_image_url"]
      when Net::HTTPRedirection
        @message = "Redirection: code=#{response.code} message=#{response.message}"
      else
        @message = "HTTP ERROR: code=#{response.code} message=#{response.message}"
      end
    rescue => exception
      
    end
    # query = params[:query]
    # return unless query.present?

    # spotify = SpotifyRepository.new
    # sounds = spotify.search(query)
    # @results = formatted(sounds)
  end
end

# private
#   def formatted(response)
#     JSON.parse(response.body)["tracks"]
#   end
