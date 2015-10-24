# Users
User.create!(name:  "Nick",
             email: "nres@umich.edu",
             password:              "DEN11.23",
             password_confirmation: "DEN11.23",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "Sam",
             email: "samcorey@umich.edu",
             password:              "baebabae",
             password_confirmation: "baebabae",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)
