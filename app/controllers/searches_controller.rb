# frozen_string_literal: true

class SearchesController < ApplicationController
  def index
    # どの単語でも
    words = params[:query]
    search_words = "q=#{words}"

    # params = URI.encode_www_form({search: search_words})
    # params = URI.encode_www_form({search: "q=Kendrick%20Lamar"})
    token = ENV["CLIENT_ACCESS_TOKEN"]
    uri = URI.parse("https://api.genius.com/search?#{search_words}")
    @query = uri.query
    http = Net::HTTP.new(uri.host, uri.port)

    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    # response = Net::HTTP.start(uri.host, uri.port) do |http|
    #   http.open_timeout = 5
    #   http.read_timeout = 10
    #   http.get(uri.request_uri)
    # end
    # ここは動いてる

    # binding.pry

    req = Net::HTTP::Get.new(uri.request_uri)
    req["Authorization"] = "Bearer #{token}"

    # Authorizationになにも入っていないから入れる
    # binding.pry

    response = http.request(req)
    # api_response = JSON.parse(res.body)

    # binding.pry

    # このとってきかたに問題がある@resultとか全部hashなのでhashを勉強し直す
    begin
      case response
      when Net::HTTPSuccess
        @result = JSON.parse(response.body)
        # 全部nilだからデータのとってきかたに問題がある
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
      @message = "e.message"
    end

    binding.pry
    # query = params[:query]
    # return unless query.present?

    # spotify = SpotifyRepository.new
    # sounds = spotify.search(query)
    # @results = formatted(sounds)
  end
  end

  def show
    
  end

# private
#   def formatted(response)
#     JSON.parse(response.body)["tracks"]
#   end
