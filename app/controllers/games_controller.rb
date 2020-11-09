require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabet = ("A".."Z").to_a
    @letters = []
    10.times { @letters << alphabet.sample }
  end

  def score
    return @result = :wrong_letters unless word_uses_letters?

    @result = word_exists? ? :won : :wrong_word
  end

  private

  def word_uses_letters?
    word = params[:word].split('')
    letters = params[:letters].split(' ')
    word.each do |letter|
      letter_index = letters.index(letter.upcase)
      return false if letter_index.nil?

      letters.delete_at(letter_index)
    end
    true
  end

  def word_exists?
    serialized_answer = open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read
    answer = JSON.parse(serialized_answer)
    answer['found']
  end
end