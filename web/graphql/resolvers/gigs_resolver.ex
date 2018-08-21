defmodule GigsHunt.Resolver.Gigs do
  alias GigsHunt.Repo
  alias GigsHunt.Gigs
  alias GigsHunt.Package


  # Inserts gigs based on the gigs argument, subcategory_id, user_id

  defp insert_gigs(gigs_args, sub_category_id, user_id) do
    gigs_changeset= Gigs.changeset(%Gigs{sub_category_id: sub_category_id, user_id: user_id}, gigs_args)
    Repo.insert(gigs_changeset)
  end

  # Insert Package data for that gigs

  defp insert_package_list(package_args, gigs_id) do
    packages= Enum.each(package_args, fn(package) ->
        package_changeset=Package.changeset(%Package{gigs_id: gigs_id}, package)
        {:ok, package_info}=Repo.insert(package_changeset)
        package_info
    end)

    {:ok, packages}
  end

  # insert single package passed with args
  defp insert_package(package_args, gigs_id) do
    package_changeset= Package.changeset(%Package{gigs_id: gigs_id}, package_args)
    Repo.insert(package_changeset)
  end

  # update package function
  defp update_package(package_args,package_data) do
    package_changeset= Package.changeset(package_data, package_args)
    case Repo.update(package_changeset) do
      {:ok, updated_package} ->
        {:ok, updated_package}

      {:error, error_changeset} ->
        IO.inspect error_changeset
        {:error, %{message: "cannot update package"}}
    end
  end

  # find Package with Gigs
  defp find_package_with_gigs(package_id, gigs_id) do
    case Repo.get_by(Package, id: package_id, gigs_id: gigs_id) do
       nil ->
         nil

        package ->
          {:ok, package}
    end
  end

  # Update gigs based on the params provided
  defp update_gigs(gigs_args, gigs_data) do
    gigs_changeset = GigsHunt.Gigs.changeset(gigs_data, gigs_args)
    case Repo.update(gigs_changeset) do
      {:ok, gigs} ->
        {:ok, gigs}

      {:error, changeset} ->
        IO.inspect changeset
        {:error, %{message: "Oops! something went wrong couldn't update "}}
    end

  end

  defp archive(gigs_data) do
    gigs_changeset = Gigs.changeset(gigs_data, %{archived: true})
    case Repo.update(gigs_changeset) do
      {:ok, archived_gigs} ->
        {:ok, archived_gigs}

      {:error, _error_changeset} ->
        {:error, %{message: "Oops! couldn't archive gigs"}}
    end
  end



  @doc """
    Finds Gigs from the gigs Schema
  """
  def find(%{id: id}, _info) do
      case Repo.get(Gigs, id) do
        nil ->
          {:error, "Opps gigs Not found"}
        gigs ->

          {:ok, gigs}
      end
  end


  @doc """
    build gigs args, find assotiations , insert gigs and package with association
  """

  def insert(%{title: title, price: price, description: description, time_period: time_period, time_unit: time_unit } = gigs_args, %{context: %{current_user: user}}) do

    # format links if its passed into argument
    gigs_args_with_links=
      if(gigs_args.links) do
       %{gigs_args | links: %{data: gigs_args.links}}
     else
       %{gigs_args | links: %{data: []}}
     end

    # finding sub_category & user info for associations
    sub_category= Repo.get_by(GigsHunt.SubCategory, id: gigs_args_with_links.sub_category_id)
    case insert_gigs(gigs_args_with_links, sub_category.id, user.id) do
      {:ok, gigs} ->
        {:ok, gigs}

      {:error, _error_changeset} ->
        {:error, %{message: "couldn't create Gigs"}}
    end
  end

  def insert(_gigs_params, _info) do
    {:error, %{message: "User not Logged In"}}
  end


  # gigs detail query
  def gigs_detail(%{url: url}, _info) do
    gigs_detail_data = Repo.get_by(Gigs, slug_url: url)

    case gigs_detail_data do
      nil ->
        {:error, %{message: "Opps! We didn't find what you are looking for"}}

      _ ->
        {:ok, gigs_detail_data}


    end
  end

  @doc """
    fetch gigs_detail by id
  """
  def gigs_detail_user(%{id: id}, %{context: %{current_user: user}}) do
    gigs_detail_data = Repo.get_by(Gigs, id: id, user_id: user.id)

    case gigs_detail_data do
      nil ->
        {:error, %{message: "Opps! We didn't find what you are looking for"}}

      _ ->
        {:ok, gigs_detail_data}

    end
  end

  @doc """
    throw error if user is not logged in
  """
  def gigs_detail_user(_params, _info) do
    {:error, %{message: "you need to login to view this"}}
  end

  @doc """
    insert package for gigs if user is logged in
  """
  def insert_gigs_package(package_args, %{context: %{current_user: user}}) do
    gigs_info = Repo.get_by(Gigs, id: package_args.gigs_id, user_id: user.id)
    case gigs_info do
      nil ->
        {:error, %{message: "You cannot add package to gigs that doesn't belong to you "}}

      _gigs ->
        insert_package(package_args.package,gigs_info.id)
    end
  end

  @doc """
    insert gig function if user is not logged in
  """
  def insert_gigs_package(_package_args, _info)do
    {:error, %{message: "User not logged in"}}
  end

  @doc """
    update gigs if user is logged in
  """
  def update_gigs_mutation(gigs_args,  %{context: %{current_user: user}}) do
    gigs_data = Repo.get_by(Gigs, id: gigs_args.gigs_id, user_id: user.id)
    case gigs_data do
      nil ->
        {:error, %{message: "You cannot edit gigs that doesn't belong to you"}}

      _gigs ->
        update_gigs(gigs_args, gigs_data)

    end
  end

  def update_gigs_mutation(_gigs_args, _info) do
    {:error, %{message: "You must login to update gigs"}}
  end

  @doc """
    update package for gigs

  """
  def update_gigs_package(package_args, %{context: %{current_user: user}}) do

    with  gigs <- Repo.get_by(Gigs, id: package_args.gigs_id, user_id: user.id),
          {:ok, package} <- find_package_with_gigs(package_args.package_id, gigs.id) do


          update_package(package_args.package, package)

    else
      nil ->
        {:error, %{message: "Couldn't find package"}}
    end
  end

  @doc """
    archive gigs
  """
  def archive_gigs(%{gigs_id: id}, %{context: %{current_user: user}}) do
    case Repo.get_by(Gigs, id: id, user_id: user.id) do
      nil ->
        {:error, %{message: "Couldn't find Gigs  to Archive"}}

      gigs ->
        archive(gigs)
    end
  end

  def archive_gigs(_params, _info) do
    {:error, %{message: "Please login to archive gigs"}}
  end

  @doc """
    Upload Gigs
  """
  def upload_gigs(args,  %{context: %{current_user: user}}) do
    IO.inspect args
  end

  def upload_gigs(_args, _info) do
    {:error, %{message: "please login to upload gigs"}}
  end
end
