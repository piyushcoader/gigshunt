roles = [
  %{type: "verified"},
  %{type: "admin"},
  %{type: "blocked"},
  %{type: "unverified"}
]

Enum.map(roles, fn(x) ->
  roles_changeset= GigsHunt.Roles.changeset(%GigsHunt.Roles{}, x)
  GigsHunt.Repo.insert(roles_changeset)
end)
