#!/usr/bin/env ruby
$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "console"
require "console_game_maker"
require "console_display"
require "console_board_displayer"
require "player_factory"

console_display = ConsoleDisplay.new($stdin, $stdout)
board_displayer = ConsoleBoardDisplayer.new(console_display)
player_factory = PlayerFactory.new(console_display)
console_app = Console.new(ConsoleGameMaker.new(player_factory, board_displayer), console_display)
console_app.run
