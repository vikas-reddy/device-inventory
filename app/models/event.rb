class Event < ActiveRecord::Base
  attr_accessible :event_type, :device_id

  def self.record_event(device_id, message)
    Event.create(:device_id => device_id, :event_type => message)
  end
end
