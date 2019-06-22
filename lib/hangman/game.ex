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

end
