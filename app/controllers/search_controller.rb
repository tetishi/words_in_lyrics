# frozen_string_literal: true

class SearchController < ApplicationController
  def index
  end

  def show
    query = params[:query]
    return unless query.present?

    spotify = SpotifyRepository.new
    sounds = spotify.search(query)
    @results = formatted(sounds)
  end
end

private
  def formatted(response)
    JSON.parse(response.body)["tracks"]
  end
