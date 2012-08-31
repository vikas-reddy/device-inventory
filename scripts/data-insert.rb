50.times do
  device = Device.create(
    :serial_num => SecureRandom.base64(6).gsub(/[$=+\/]/,65.+(rand(25)).chr),
    :device_type => ['Smartphone', 'Tablet'].sample,
    :make => %w(Apple HTC Samsung Nokia Toshiba Amazon Google Asus Acer).sample,
    :model => %w(Desire Star GalaxyS1 GalaxyS2 PropFire Kindle Water Air Cool 5230 5530 1210 1230 2783 27491 Nexus Defy Insist).sample,
    :os => %w(iOS Android PalmOS Symbian Meego Maemo).sample,
    :os_version => %w(1.2.3 2.3.4 3.4.5 4.5.6).sample,
    :environment => %w(Production Development Staging Testing Deployment).sample,
    :project => SecureRandom.base64(10).gsub(/[$=+\/]/,65.+(rand(25)).chr),
    :phone_num => 2934567812,
    :service_provider => SecureRandom.base64(10).gsub(/[$=+\/]/,65.+(rand(25)).chr),
    :mac_addr => SecureRandom.base64(15).gsub(/[$=+\/]/,65.+(rand(25)).chr),
    :ip_addr => "#{rand(9)}#{rand(9)}#{rand(9)}.#{rand(9)}#{rand(9)}#{rand(9)}.#{rand(9)}#{rand(9)}#{rand(9)}.#{rand(9)}#{rand(9)}#{rand(9)}",
    :status => %w(Available Issued UnderRepair).sample
  )
end
