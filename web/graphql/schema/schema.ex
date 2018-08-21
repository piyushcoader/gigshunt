defmodule GigsHunt.Schema do
  use Absinthe.Schema

  import_types GigsHunt.Schema.Wallet
  import_types GigsHunt.Schema.Role
  import_types GigsHunt.Schema.User
  import_types GigsHunt.Schema.Category
  import_types GigsHunt.Schema.Package
  import_types GigsHunt.Schema.Gigs
  import_types GigsHunt.Schema.Rating
  import_types GigsHunt.Schema.Offer
  import_types GigsHunt.Schema.Message
  import_types GigsHunt.Schema.Request


  query do



    # All Category Resolver
    import_fields :category_query
    import_fields :sub_category_query

    # Roles Schema
    import_fields :role_query

    #wallet schema
    import_fields :wallet_query

    #Schema Related to Users
    import_fields :user_query

    #schema Related to Gigs
    import_fields :gigs_query

    #schema for offer
    import_fields :offer_query

    import_fields :metadata_query

    import_fields :request_query



  end


  # Mutation Goes Here
  mutation do
    # User Related Mutation
    import_fields :user_mutation

    # mutation for gigs
    import_fields :gigs_mutation

    # mutation for wallet
    import_fields :wallet_mutation

    #mutation for offer
    import_fields :offer_mutation

    #mutation for message metadata
    import_fields :metadata_mutation

    import_fields :request_mutation
  end
end
