# Users
User.create!(name:  "Nick",
             email: "nres@umich.edu",
             password:              "DEN11.23",
             password_confirmation: "DEN11.23",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

User.delete!(name:  "Sam",
             email: "samcorey@umich.edu",
             password:              "baebabae",
             password_confirmation: "baebabae",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

User.delete!(name:  "Spencer",
             email: "swgood@umich.edu",
             password:              "astro1994",
             password_confirmation: "astro1994",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "Jake",
             email: "jmbadalamenti@gmail.com",
             password:              "Jakemb1994",
             password_confirmation: "Jakemb1994",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "Jasper",
             email: "jmapollo@syr.edu",
             password:              "B*12fr*j",
             password_confirmation: "B*12fr*j",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

Topic.create!(name:  "film")
Topic.create!(name:  "music")
Topic.create!(name:  "life")