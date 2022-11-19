require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { [*'a'..'z'].sample }
  end

  def letters?(string, grid)
    n_duplicate_letters = string.chars.uniq.count { |char| string.count(char) > 1 }
    has_letters = false

    if n_duplicate_letters < 3
      has_letters = string.chars.all? do |char|
        grid.join.downcase.include? char.downcase
      end
    end

    return false if n_duplicate_letters.positive?

    has_letters
  end

  def score
    # raise
    # debugger
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)

    if word['found']
      # Verify if all letters in attempt are in generate_grid(grid)
      @message = "found #{params[:word]}"
      # if letters?(params[:word], @letters)
      #   @message = "Congratulations! #{params[:word]} is a valid English word!"
      # else
      #   @message = "Sorry but #{params[:word]} can't be built out of #{@letters}."
      # end
    else
      @message = "Sorry but #{params[:word]} does not seem to be a valid English word."
    end
    @message
  end
end
