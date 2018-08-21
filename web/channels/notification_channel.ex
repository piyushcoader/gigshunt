defmodule GigsHunt.NotificationChannel do
  use Phoenix.Channel
  alias GigsHunt.Repo
  import Ecto.Query, only: [from: 2]
end
