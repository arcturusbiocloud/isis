defmodule Isis.User do
  use Ecto.Model

  schema "users" do
    field :email, :string
    field :password, :string
    field :created_at, :datetime, default: Ecto.DateTime.local
    field :updated_at, :datetime, default: Ecto.DateTime.local
  end
  
  # Isis.User.validate(%Isis.User{})
  # => %{email: ["can't be blank"], password: ["must be present"]}
  validate user,
    also: validate_password,
    also: validate_email
    
  validatep validate_email(user),
    email: present() and has_format(~r"^[^@]+@[^@]+\.[^@]+$")

  validatep validate_password(user),
    password: present()
    
  def create(params) do
    email    = if is_binary(params[:email]), do: String.downcase(params[:email]), else: params[:email]
    password = params[:password]
    now      = Ecto.DateTime.utc
    user     = %Isis.User{email: email, password: password,
                          created_at: now, updated_at: now}
    
    case validate(user) do
      nil ->
        user = %{user | password: gen_password(password)}
        { :ok, Isis.Repo.insert(user) }
      errors ->
        { :error, Enum.into(errors, %{}) }
    end
  end
  
  def update(user, params) do
    errors = []
    email    = if is_binary(params[:email]), do: String.downcase(params[:email]), else: params[:email]
    password = params[:password]
    if email do
      user = %{user | email: String.downcase(email)}
      if v = validate_email(user) do errors = errors ++ v end
    end
    if password && String.length(password) > 0 do
      user = %{user | password: password}
      if v = validate_password(user) do errors = errors ++ v end
      user = %{user | password: gen_password(password)}
    end
    case errors do
      [] ->
        user = %{user | updated_at: Ecto.DateTime.utc}
        Isis.Repo.update(user)
        { :ok, user }
      errors ->
        { :error, Enum.into(errors, %{}) }
    end
  end
  
  def get(nil), do: nil
  
  def get(email) do
    from(u in Isis.User,
         where: downcase(u.email) == downcase(^email),
         limit: 1)
    |> Isis.Repo.all
    |> List.first
  end
  
  def auth?(nil, _password), do: false
  
  def auth?(user, password) do
    stored_hash   = user.password
    password      = String.to_char_list(password)
    stored_hash   = :erlang.binary_to_list(stored_hash)
    { :ok, hash } = :bcrypt.hashpw(password, stored_hash)
    hash == stored_hash
  end
  
  defp gen_password(password) do
    password      = String.to_char_list(password)
    work_factor   = 4
    { :ok, salt } = :bcrypt.gen_salt(work_factor)
    { :ok, hash } = :bcrypt.hashpw(password, salt)
    :erlang.list_to_binary(hash)
  end
  
end