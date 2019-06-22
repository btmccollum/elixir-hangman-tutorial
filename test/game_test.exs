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

  test "state isn't changed for :won or :lost games" do
    for state <- [ :won, :lost ] do
      game = Game.new_game()
      |> Map.put(:game_state, :won)

      # pinning the game, so only valid if the game from agove matches
      assert { ^game, _ } = Game.make_move(game, "X")
    end
  end
end
