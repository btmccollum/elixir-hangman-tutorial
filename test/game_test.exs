# testing internal state for game

defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.word_to_guess) > 0
  end

  test "new_game word_to_guess is all downcase characters between a..z" do
    game = Game.new_game()
    word = List.to_string(game.word_to_guess)

    assert word == String.downcase(word)
  end

end
