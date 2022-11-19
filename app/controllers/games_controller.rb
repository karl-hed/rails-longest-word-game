require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { [*'a'..'z'].sample }
    # @letters = %w[h e l l o]
    # @letters = %w[w a g o n]
    # session[:letters] = @letters
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
    # @letters = session[:letters] OR   <%= hidden_field_tag :letters, @letters %> in new.html.erb
    # USE @letters                            params[:letters]

    if word['found']
      # Verify if all letters in attempt are in generate_grid(grid)
      @message = "Congratulations! #{params[:word]} is a valid English word!"
    elsif letters?(params[:word], params[:letters]) == false
      @message = "Sorry but #{params[:word]} can't be built out of #{@letters}."
    else
      @message = "Sorry but #{params[:word]} does not seem to be a valid English word."
    end
    @message
  end
end
