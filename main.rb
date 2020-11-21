# frozen_string_literal: true

require_relative 'game'

puts "Enter your name:"
name = gets.chomp

game = Game.new(name, 100)
game.run
