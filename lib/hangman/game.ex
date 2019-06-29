defmodule Hangman.Game do

  # specify keys and default values used when creating a structure
  # creates a named map structure that matches the name of the module
  defstruct(
    turns_left:     7,
    game_state:     :initializing,
    word_to_guess:  [],
    guessed:        MapSet.new(),
  )
  def new_game() do
    # word being guessed
    # turns left
    # letters being guessed

    # putting the name of the structure between % and {} (map) utilizes the structure defined above
    %Hangman.Game{
      word_to_guess: Dictionary.random_word |> String.codepoints
    }
  end

  # pattern matching for similar functions
  # def make_move(game = %{ game_state: :won}, _guess) do
  #   { game, tally(game) }
  # end

  # def make_move(game = %{ game_state: :lost}, _guess) do
  #   { game, tally(game) }
  # end

  # combined version with when clause
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
  end

  def tally(game) do
    123
  end



end
