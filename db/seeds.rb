# Seed Users
user = {}
user['password'] = 'asdf'

ActiveRecord::Base.transaction do
  20.times do
    user['first_name'] = Faker::Name.first_name
    user['last_name'] = Faker::Name.last_name
    user['email'] = Faker::Internet.email


    User.create(user)
  end
end

# Seed Listings
listing = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  40.times do
    listing['title'] = Faker::App.name
    listing['description'] = Faker::Hipster.sentence
    listing['home_type'] = ["House", "Entire Floor", "Condominium", "Villa", "Townhouse", "Castle", "Treehouse", "Igloo", "Yurt", "Cave", "Chalet", "Hut", "Tent", "Other"].sample
    listing['room_type'] = ["Master", "Bedroom", "Study", "Basement", "Triple", "Double" "Single", "Queen", "King"].sample

    listing['maximum_guests'] = rand(0..10)
    listing['address'] = Faker::Address.street_address
    listing['price_per_night'] = rand(80..1000)
    listing['user_id'] = uids.sample

    Listing.create(listing)
  end
end
