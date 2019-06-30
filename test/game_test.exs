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

  test "first occurrence of letter is not already used" do
    game = Game.new_game()
    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state != :already_guessed
  end

  test "second occurrence of letter is already used" do
    game = Game.new_game()
    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state != :already_guessed
    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state == :already_guessed
  end

  test "a good guess is recognized" do
    game = Game.new_game("wibble")
    { game, _tally } = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won game" do
    game = Game.new_game("wibble")

    { game, _tally } = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7

    { game, _tally } = Game.make_move(game, "i")
    assert game.game_state == :good_guess
    assert game.turns_left == 7

    { game, _tally } = Game.make_move(game, "b")
    assert game.game_state == :good_guess
    assert game.turns_left == 7

    { game, _tally } = Game.make_move(game, "l")
    assert game.game_state == :good_guess
    assert game.turns_left == 7

    { game, _tally } = Game.make_move(game, "e")
    assert game.game_state == :won
    assert game.turns_left == 7
  end

  test "bad guess is recognized" do
    game = Game.new_game("wibble")
    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "loss is recognized" do
    game = Game.new_game("wibble")
    { game, _tally } = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6

    { game, _tally } = Game.make_move(game, "y")
    assert game.game_state == :bad_guess
    assert game.turns_left == 5

    { game, _tally } = Game.make_move(game, "z")
    assert game.game_state == :bad_guess
    assert game.turns_left == 4

    { game, _tally } = Game.make_move(game, "c")
    assert game.game_state == :bad_guess
    assert game.turns_left == 3

    { game, _tally } = Game.make_move(game, "r")
    assert game.game_state == :bad_guess
    assert game.turns_left == 2

    { game, _tally } = Game.make_move(game, "j")
    assert game.game_state == :bad_guess
    assert game.turns_left == 1

    { game, _tally } = Game.make_move(game, "k")
    assert game.game_state == :lost
  end
end
