class Request < ActiveRecord::Base
  attr_accessible :device_id, :owner, :requestor
  belongs_to :device
end
