class Event < ActiveRecord::Base
  attr_accessible :event_type, :device_id

  default_scope order('created_at DESC')

  paginates_per 20

  def self.record_event(device_id, message)
    Event.create(:device_id => device_id, :event_type => message)
  end
end
