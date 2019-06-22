defmodule Hangman.Game do

  # specify keys and default values used when creating a structure
  # creates a named map structure that matches the name of the module
  defstruct(
    turns_left:     7,
    game_state:     :initializing,
    word_to_guess:  [],

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

  def tally(game) do
    123
  end



end
