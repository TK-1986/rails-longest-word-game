class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
    @letters.shuffle!
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    @result = run_game(@word, @letters)
    @session = session[:score]
    render json: { score: @result }
  end

  def run_game(word, letters)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = open(url).read
    word = JSON.parse(word_serialized)
    if word["found"] == false
      return "not an english word"
    elsif word["length"] > letters.length
      return "not in the grid"
    else
      return "well done"
    end
  end
end
