require 'json'
require 'open-uri'


class GamesController < ApplicationController
  def new
    @random = random
  end

  def score
    @guess = params[:guess].upcase
    is_english
    guess_is_grid
    counting_score
  end

  def random
    characters = ('A'..'Z').to_a
    @grid = []
    9.times do
      @grid << characters.shuffle.take(1)
    end
    @grid.flatten
  end

  def guess_is_grid
    @guess = params[:guess].upcase
    @grid = random
    if @guess.chars.all? { |letter| @grid.include? letter }
        @griddy = ""
    else @griddy = "not"
    end
  end

  def is_english
    @guess = params[:guess].upcase
    @url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
    word_hash = open(@url).read
    word_parsed = JSON.parse(word_hash)
    if word_parsed["found"] == true
       @answer = ""
    else
       @answer = "not"
    end
  end

  def counting_score
    if is_english == "not" || guess_is_grid == "not"
      @score = 0
    else
      @score = params[:guess].chars.count
    end
  end
end

