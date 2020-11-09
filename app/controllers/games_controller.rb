require 'json'
require 'open-uri'


class GamesController < ApplicationController
  def new
    @guess = params[:guess]
    @random = random
  end

  def score
    @guess = params[:guess]
    @is_english = is_english
    @end = Time.now
    @counting_score = counting_score
  end

  def random
    characters = ('A'..'Z').to_a
    @grid = []
    9.times do
      @grid << characters.shuffle.take(1)
    end
    @grid
  end

  def counting_score
    @score = 0
    @start = Time.now
    @start
  end

  def is_english
    @guess = params[:guess]
    @url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
    word_hash = open(@url).read
    word_parsed = JSON.parse(word_hash)
    if word_parsed["found"] == true
       @answer = ""
    else
       @answer = "not"
    end
  end
end

