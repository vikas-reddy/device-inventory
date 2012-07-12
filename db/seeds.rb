# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

p "Loading seed data from db/defaults.yml"
SEED_DATA = YAML.load_file("#{Rails.root}/db/defaults.yml")


p "Seeding table `device_types`"
SEED_DATA['device_types'].each do |device_type|
  DeviceType.create(name: device_type)
end

p "Seeding table `accessory_types`"
SEED_DATA['accessory_types'].each do |accessory_type|
  AccessoryType.create(name: accessory_type)
end
