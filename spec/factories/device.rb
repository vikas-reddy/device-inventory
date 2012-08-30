FactoryGirl.define do

  sequence :serial_num do |n|
    "CMV29XCV#{n}EWRH"
  end

  factory :device do
    serial_num
    manufacturer                "Samsung"
    model                       "Galaxy S4"
    os                          "Android"
    os_version                  "4.1 Jellybean"
    environment                 "Development"
    project                     "ProjectName"
    phone_num                   "9898988989"
    service_provider            "Airtel"
    mac_addr                    "99:d1:7d:ab:3f:9b"
    ip_addr                     "10.0.1.23"
    state                       "available"
    owner                       "vikasr"
    possessor                   ""
    property_of                 "ClientName"
    label                       "212"
    imei                        "198723498342675"
  end
end
