# should not know about internal implementation of app
defmodule Hangman do
  # if you dont inclue as, it just uses the last part, so it becomes 'Game'
  alias Hangman.Game

  # defdelegate delegates it down to a different functions, so when Hangman.newgame() is a call to Hangman.Game.newgame()
  defdelegate new_game(), to: Game

end
