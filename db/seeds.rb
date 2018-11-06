admin = User.create(first_name: 'Steven', last_name: 'Suzuki', email: 'suzukisteven@gmail.com', role: 'superadmin', password: "123456")

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
    listing['title'] = Faker::SiliconValley.motto
    listing['description'] = Faker::SiliconValley.quote
    listing['home_type'] = ["House", "Apartment", "Secondary Unit", "Boutique Hotel", "Bed & Breakfast", "Unique Space"].sample
    listing['property_type'] = ["House", "Apartment", "Bungalow", "Cabin", "Casa Particular", "Chalet", "Cottage", "Cycladic House", "Dammuso (Italy)", "Dome House", "Earth House", "Farm stay", "Houseboat", "Hut", "Lighthouse", "Pension (South Korea)", "Tiny Home", "Villa"].sample
    listing['country'] = Faker::Address.country
    listing['street_address'] = Faker::Address.street_address
    listing['room_number'] = rand(1..100)
    listing['city'] = Faker::Address.city
    listing['state'] = Faker::Address.state
    listing['zip_code'] = Faker::Address.zip_code
    listing['beds'] = ["1 Bed", "2 Beds", "3 Beds", "4 Beds", "5 Beds", "6 Beds", "7 Beds", "8 Beds", "9 Beds", "10 Beds"].sample
    listing['bathrooms'] = ["1 Bathroom", "2 Bathrooms", "3 Bathrooms", "4 Bathrooms", "5 Bathrooms", "6 Bathrooms", "7 Bathrooms", "8 Bathrooms", "9 Bathrooms", "10 Bathrooms"].sample
    listing['amenities'] = []
    rand(1..6).times do
      listing['amenities'] << ["Essentials", "Wifi", "Shampoo", "Closet/Drawers", "TV", "Heat", "Air Conditioning", "Breakfast, Coffee, Tea", "Desk/Workspace", "Fireplace", "Iron", "Hairdryer", "Pets in the house", "Private Entrance", "First aid kit"].sample
    end
    listing['shared_spaces'] = []

    rand(1..6).times do
      listing['shared_spaces'] << ["Pool", "Kitchen", "Laundry - Washer", "Laundry - Dryer", "Parking", "Elevator", "Hot Tub", "Gym"].sample
    end
    listing['maximum_guests'] = rand(0..20)
    listing['price_per_night'] = rand(100..1000)
    listing['images'] = []
    3.times do
      listing['images'] << Rails.root.join("app/assets/images/#{rand(1..10)}.jpg").open
    end

    listing['user_id'] = uids.sample
    # byebug
    Listing.create(listing)
  end
end
