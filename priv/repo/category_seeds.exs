# category graphics and design

category_graphics = %{
  title: "Graphics & Design",
  verified?: true,
  sub_category: [
    %{title: "Logo Design", verified?: true},
    %{title: "Business Cards & Stationery", verified?: true},
    %{title: "Illustration", verified?: true},
    %{title: "Cartoons & Caricatures", verified?: true},
    %{title: "Flyers & Posters", verified?: true},
    %{title: "Book Covers & Packaging", verified?: true},
    %{title: "Web & Mobile Design", verified?: true},
    %{title: "Social Media Design", verified?: true},
    %{title: "Banner Ads", verified?: true},
    %{title: "Photoshop Editing", verified?: true},
    %{title: "3D & 2D Models", verified?: true},
    %{title: "T-Shirts", verified?: true},
    %{title: "Presentation Design", verified?: true},
    %{title: "Infographics", verified?: true},
    %{title: "Vector Tracing", verified?: true},
    %{title: "Invitations", verified?: true},
    %{title: "Other", verified?: true},
  ]
}

category_graphic_changeset= GigsHunt.Category.changeset(%GigsHunt.Category{}, category_graphics)
{:ok, category} = GigsHunt.Repo.insert(category_graphic_changeset)
Enum.map(category_graphics.sub_category, fn(x) ->
   sub_category_changeset= GigsHunt.SubCategory.changeset(%GigsHunt.SubCategory{category_id: category.id}, x)
   GigsHunt.Repo.insert(sub_category_changeset)
end)


# Digital Marketting

digital_marketting= %{
  title: "Digital Marketing",
  verified?: true,
  sub_category: [
    %{title: "Social Media Marketing", verified?: true},
    %{title: "SEO", verified?: true},
    %{title: "Web Traffic", verified?: true},
    %{title: "Content Marketing", verified?: true},
    %{title: "Social Video Marketing", verified?: true},
    %{title: "Email Marketing", verified?: true},
    %{title: "SEM", verified?: true},
    %{title: "Marketing Strategy", verified?: true},
    %{title: "Web Analytics", verified?: true},
    %{title: "Influencer Marketing", verified?: true},
    %{title: "Local Listings", verified?: true},
    %{title: "Domain Research", verified?: true},
    %{title: "Mobile Advertising", verified?: true},
    %{title: "Other", verified?: true}
  ]
}
category_changeset= GigsHunt.Category.changeset(%GigsHunt.Category{}, digital_marketting)
{:ok, category} = GigsHunt.Repo.insert(category_changeset)

Enum.map(digital_marketting.sub_category, fn(x) ->
   sub_category_changeset= GigsHunt.SubCategory.changeset(%GigsHunt.SubCategory{category_id: category.id}, x)
   GigsHunt.Repo.insert(sub_category_changeset)
end)
# Writing & Translation

writing_and_translation = %{
  title: "Writing & Translation",
  verified?: true,
  sub_category: [
    %{title: "Resumes & Cover Letters", verified?: true},
    %{title: "Proofreading & Editing", verified?: true},
    %{title: "Translation", verified?: true},
    %{title: "Creative Writing", verified?: true},
    %{title: "Business Copywriting", verified?: true},
    %{title: "Research & Summaries", verified?: true},
    %{title: "Articles & Blog Posts", verified?: true},
    %{title: "Press Releases", verified?: true},
    %{title: "Transcription", verified?: true},
    %{title: "Legal Writing", verified?: true},
    %{title: "Other", verified?: true}
  ]
}
category_changeset= GigsHunt.Category.changeset(%GigsHunt.Category{}, writing_and_translation)
{:ok, category} = GigsHunt.Repo.insert(category_changeset)

Enum.map(writing_and_translation.sub_category, fn(x) ->
   sub_category_changeset= GigsHunt.SubCategory.changeset(%GigsHunt.SubCategory{category_id: category.id}, x)
   GigsHunt.Repo.insert(sub_category_changeset)
end)

# Video & Animation
video_and_annimation = %{
  title: "Video & Animation",
  verified?: true,
  sub_category: [
    %{title: "Whiteboard & Explainer Videos", verified?: true},
    %{title: "Intros & Animated Logos", verified?: true},
    %{title: "Promotional & Brand Videos", verified?: true},
    %{title: "Editing & Post Production", verified?: true},
    %{title: "Lyric & Music Videos", verified?: true},
    %{title: "Spokespersons & Testimonials", verified?: true},
    %{title: "Animated Characters & Modeling", verified?: true},
    %{title: "Other", verified?: true},
  ]
}

category_changeset= GigsHunt.Category.changeset(%GigsHunt.Category{}, video_and_annimation)
{:ok, category} = GigsHunt.Repo.insert(category_changeset)

Enum.map(video_and_annimation.sub_category, fn(x) ->
   sub_category_changeset= GigsHunt.SubCategory.changeset(%GigsHunt.SubCategory{category_id: category.id}, x)
   GigsHunt.Repo.insert(sub_category_changeset)
end)

# Music & Audio

music_and_audio= %{
  title: "Music & Audio",
  verified?: true,
  sub_category: [
    %{title: "Voice Over", verified?: true},
    %{title: "Mixing & Mastering", verified?: true},
    %{title: "Producers & Composers", verified?: true},
    %{title: "Singer-Songwriters", verified?: true},
    %{title: "Session Musicians & Singers", verified?: true},
    %{title: "Jingles & Drops", verified?: true},
    %{title: "Sound Effects", verified?: true},
    %{title: "Other", verified?: true}
  ]
}

category_changeset= GigsHunt.Category.changeset(%GigsHunt.Category{}, music_and_audio)
{:ok, category} = GigsHunt.Repo.insert(category_changeset)

Enum.map(music_and_audio.sub_category, fn(x) ->
   sub_category_changeset= GigsHunt.SubCategory.changeset(%GigsHunt.SubCategory{category_id: category.id}, x)
   GigsHunt.Repo.insert(sub_category_changeset)
end)

#
programming_and_tech = %{
  title: "Programming & Tech",
  verified?: true,
  sub_category: [
    %{title: "WordPress", verified?: true},
    %{title: "Website Builders & CMS", verified?: true},
    %{title: "Web Programming", verified?: true},
    %{title: "Ecommerce", verified?: true},
    %{title: "Mobile Apps & Web", verified?: true},
    %{title: "Desktop applications", verified?: true},
    %{title: "Support & IT", verified?: true},
    %{title: "Data Analysis & Reports", verified?: true},
    %{title: "Convert Files", verified?: true},
    %{title: "Databases", verified?: true},
    %{title: "User Testing", verified?: true},
    %{title: "QA", verified?: true},
    %{title: "Other", verified?: true}
  ]
}

category_changeset= GigsHunt.Category.changeset(%GigsHunt.Category{}, programming_and_tech)
{:ok, category} = GigsHunt.Repo.insert(category_changeset)

Enum.map(programming_and_tech.sub_category, fn(x) ->
   sub_category_changeset= GigsHunt.SubCategory.changeset(%GigsHunt.SubCategory{category_id: category.id}, x)
   GigsHunt.Repo.insert(sub_category_changeset)
end)

# Advertising
advertising = %{
  title: "Advertising",
  verified?: true,
  sub_category: [
    %{title: "Music Promotion", verified?: true},
    %{title: "Radio", verified?: true},
    %{title: "Banner Advertising", verified?: true},
    %{title: "Flyers & Handouts", verified?: true},
    %{title: "Pet Models", verified?: true},
    %{title: "Other", verified?: true}
  ]
}

category_changeset= GigsHunt.Category.changeset(%GigsHunt.Category{}, advertising)
{:ok, category} = GigsHunt.Repo.insert(category_changeset)

Enum.map(advertising.sub_category, fn(x) ->
   sub_category_changeset= GigsHunt.SubCategory.changeset(%GigsHunt.SubCategory{category_id: category.id}, x)
   GigsHunt.Repo.insert(sub_category_changeset)
end)

# businesss
business = %{
  title: "Business",
  verified?: true,
  sub_category: [
    %{title: "Virtual Assistant", verified?: true},
    %{title: "Market Research", verified?: true},
    %{title: "Business Plans", verified?: true},
    %{title: "Branding Services", verified?: true},
    %{title: "Legal Consulting", verified?: true},
    %{title: "Financial Consulting", verified?: true},
    %{title: "Business Tips", verified?: true},
    %{title: "Presentations", verified?: true},
    %{title: "Career Advice", verified?: true},
    %{title: "Other", verified?: true},

    ]
}

category_changeset= GigsHunt.Category.changeset(%GigsHunt.Category{}, business)
{:ok, category} = GigsHunt.Repo.insert(category_changeset)

Enum.map(business.sub_category, fn(x) ->
   sub_category_changeset= GigsHunt.SubCategory.changeset(%GigsHunt.SubCategory{category_id: category.id}, x)
   GigsHunt.Repo.insert(sub_category_changeset)
end)

# fun and life style

# fun_and_life_style= %{
#  title: "Fun & Lifestyle",
#  verified: true,
#  sub_category: [
#    %{title: "Online Lessons", verified?: true},
#    %{title: "Arts & Crafts", verified?: true},
#    %{title: "Health, Nutrition & Fitness", verified?: true},
#        %{title: "Relationship Advice", verified?: true},
#    %{title: "Astrology & Readings", verified?: true},
#    %{title: "Spiritual & Healing", verified?: true},
#    %{title: "Family & Genealogy", verified?: true},
#    %{title: "Collectibles", verified?: true},
#    %{title: "Greeting Cards & Videos", verified?: true},
#    %{title: "Your Message On...", verified?: true},
#    %{title: "Viral Videos", verified?: true},
#    %{title: "Pranks & Stunts", verified?: true},
#    %{title: "Celebrity Impersonators", verified?: true},
#    %{title: "Gaming", verified?: true},
#    %{title: "Global Culture", verified?: true}
#  ]
#}
#category_changeset= GigsHunt.Category.changeset(%GigsHunt.Category{}, fun_and_life_style)
#{:ok, category} = GigsHunt.Repo.insert(category_changeset)

#Enum.map(fun_and_life_style.sub_category, fn(x) ->
#   sub_category_changeset= GigsHunt.SubCategory.changeset(%GigsHunt.SubCategory{category_id: category.id}, x)
#   GigsHunt.Repo.insert(sub_category_changeset)
#end)
#"""
