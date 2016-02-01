#!/usr/bin/env ruby
$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "console_app"
require "console_game_maker"
require "console_ui"
require "tictactoe/player_factory"

console_ui = ConsoleUI.new($stdin, $stdout)
player_factory = TicTacToe::PlayerFactory.new(console_ui)
console_app = ConsoleApp.new(ConsoleGameMaker.new(player_factory, console_ui), console_ui)
console_app.run
