# frozen_string_literal: true

require_relative 'terminal_interface'

system('clear')
puts "Welcome to the Game!\n\n\n"
puts "Enter your name:"
name = gets.chomp

game = Game.new(name, 20, 10)

interface = TerminalInterface.new(game)
interface.start_game
