defmodule Hangman.Game do

  # specify keys and default values used when creating a structure
  # creates a named map structure that matches the name of the module
  defstruct(
    turns_left:     7,
    game_state:     :initializing,
    word_to_guess:  [],
    guessed:        MapSet.new(),
  )
  def new_game(word) do
    %Hangman.Game{
      word_to_guess: word |> String.codepoints
    }
  end

  def new_game() do
    new_game(Dictionary.random_word)
  end

  def make_move(game = %{ game_state: state }, _guess) when state in [:won, :lost] do
    { game, tally(game) }
  end

  def make_move(game, guess) do
    game = accept_move(game, guess, MapSet.member?(game.guessed, guess))
    { game, tally(game) }
  end

  # adding dummy pattern matching to serve as documentation for clarification
  def accept_move(game, guess, _already_guessed = true) do
    Map.put(game, :game_state, :already_guessed)
  end

  def accept_move(game, guess, _already_guessed) do
    Map.put(game, :guessed, MapSet.put(game.guessed, guess))
    |> score_guess(Enum.member?(game.word_to_guess, guess))
  end

  def score_guess(game, _good_guess = true) do
    new_state = MapSet.new(game.word_to_guess)
    |> MapSet.subset?(game.guessed)
    |> maybe_won()
    Map.put(game, :game_state, new_state)
  end

  def score_guess(game, _not_good_guess) do
  #   dec turns left
  #   0? :lost, :bad_guess
    game
  end

  def tally(game) do
    123
  end

  def maybe_won(true), do: :won
  def maybe_won(_),    do: :good_guess


end
