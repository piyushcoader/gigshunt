defmodule GigsHunt.Schema.Gigs do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: GigsHunt.Repo
  import_types Absinthe.Plug.Types

  #input object for links
  input_object :links, name: "linksInput" do
    field :url, non_null(:string)
    field :format, non_null(:string)
  end

  input_object :files, name: "filesInput" do
    field :type, non_null(:string)
    field :file, :upload

  end

  input_object :filter_price do
     field :min, non_null(:float)
     field :max, non_null(:float)
  end

  input_object :filter_delivery do
    field :d_type, non_null(:string)
    field :d_time, non_null(:integer)
  end

  #input object for gigs
  input_object :gigs_input, name: "gigsInput" do
    field :title, non_null(:string)
    field :description, non_null(:string)
    field :links, list_of(:links)
    field :sub_category_id, non_null(:integer)
  end

  #input object for gigs update

  input_object :gigs_update_input, name: "gigsUpdateInput" do
    field :title, :string
    field :description, :string
    field :links, list_of(:links)
    field :sub_category_id, :integer
  end


  #input object for package
  input_object :package_input, name: "packageInput" do
    field :price, non_null(:float)
    field :description, :string
    field :title, non_null(:string)
    field :delivery_time, non_null(:integer)
    field :delivery_type, non_null(:string)
  end

  #input object for  filter gigs
  input_object :filter_input, name: "filterInput" do
    field :sub_category_id, :integer
    field :price, :filter_price
    field :all_sub_category, list_of(:integer)
    field :delivery, :filter_delivery
    field :pagination_from, :integer
  end

  object :links_type do
    field :url, :string do
       resolve fn gigs, _, _ -> {:ok, Map.get(gigs, "url")} end
    end
    field :format, :string do
      resolve fn gigs, _, _ -> {:ok, Map.get(gigs, "format")} end
    end
  end

  object :gigs do
    field :id, :id
    field :title, :string

    field :links, list_of(:links_type) do
      resolve fn gigs, _, _ -> {:ok, gigs.links["data"]}  end
    end

    field :archived, :boolean
    field :verified, :string
    field :description, :string
    field :slug_url, :string
    field :sub_category, :sub_category, resolve: assoc(:sub_category)
    field :rating, :rating, resolve: assoc(:rating)
    field :price, :float
    field :time_period, :integer
    field :time_unit, :string
    field :inserted_at, :string
    field :user, :user, resolve: assoc(:user)
  end


  object :gigs_query do
    field :gigs, :gigs do
      arg :id, non_null(:integer)
      resolve &GigsHunt.Resolver.Gigs.find/2
    end

    field :user_gigs_detail, :gigs do
      arg :id, non_null(:integer)
      resolve &GigsHunt.Resolver.Gigs.gigs_detail_user/2
    end

    field :gigs_detail, :gigs do
      arg :url, non_null(:string)
      resolve &GigsHunt.Resolver.Gigs.gigs_detail/2
    end

    field :filter_gigs, list_of(:gigs) do
      arg :filter_args,  :filter_input

      resolve &GigsHunt.Resolver.Gigs.Filter.filter_gigs/2
    end
  end


  object :gigs_mutation do
    field :insert_gigs, :gigs do
      arg :title, non_null(:string)
      arg :description, non_null(:string)
      arg :links, list_of(:links)
      arg :price, non_null(:float)
      arg :time_period, :integer
      arg :time_unit, :string
      arg :sub_category_id, non_null(:integer)

      resolve &GigsHunt.Resolver.Gigs.insert/2
    end

    field :update_gigs, :gigs do
      arg :title, :string
      arg :description, :string
      arg :links, list_of(:links)
      arg :price, :float
      arg :time_period, :integer
      arg :time_unit, :string
      arg :gigs_id, non_null(:integer)

      resolve &GigsHunt.Resolver.Gigs.update_gigs_mutation/2
    end

    field :archive_gigs, :gigs do
      arg :gigs_id, non_null(:integer)

      resolve &GigsHunt.Resolver.Gigs.archive_gigs/2
    end

    field :upload_links, :gigs do
      arg :files, list_of(:files)

      resolve &GigsHunt.Resolver.Gigs.upload_gigs/2
    end

    field :upload_file, :string do
        arg :users, non_null(:upload)
        arg :metadata, :upload
        resolve fn args, _ ->
          args.users # this is a `%Plug.Upload{}` struct.
          GigsHunt.Uploads.upload(%{"file" => args.users})

          IO.inspect args
          {:ok, "success"}
        end
      end
  end



end
