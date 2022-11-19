require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { [*'a'..'z'].sample }
    # @letters = %w[h e l l o]
    session[:letters] = @letters
  end

  def letters?(string, grid)
    string.chars.all? { |char| grid.join.downcase.include? char.downcase }
  end

  def score
    # raise
    # debugger
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)
    @letters = session[:letters]

    if word['found']
      # Verify if all letters in attempt are in generate_grid(grid)
      @message = "Congratulations! #{params[:word]} is a valid English word!"
      if !letters?(params[:word], @letters)
        @message = "Sorry but #{params[:word]} can't be built out of #{@letters}."
      end
    else
      @message = "Sorry but #{params[:word]} does not seem to be a valid English word."
    end
    @message
  end
end
