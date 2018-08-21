defmodule GigsHunt.Users do
  use GigsHunt.Web, :model

  schema "user" do
    field :username, :string
    field :email, :string
    field :enc_password, :string
    field :profile, :map
    field :password, :string, virtual: true
    belongs_to :role, GigsHunt.Roles
    has_many :gigs, GigsHunt.Gigs, foreign_key: :user_id
    has_one :wallet, GigsHunt.Wallets, foreign_key: :user_id
    has_many :request, GigsHunt.Request
    timestamps()
  end

  @doc """
  Builds a user changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :email, :profile])
    |> validate_required([:username, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> unique_constraint(:username)

  end

  @doc """
    build a registration changeset
  """
  def registration_changeset(struct, params \\ %{}) do
    struct
    |> changeset(params)
    |> cast(params, [:password])
    |> validate_required([:password])
    |> put_pass_hash()

  end

  def update_password_changeset(struct, params \\ %{})do
    struct
    |> cast(params, [:password])
    |> validate_required([:password])
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :enc_password, Comeonin.Bcrypt.hashpwsalt(pass))

      _ ->
        changeset
    end
  end
end
