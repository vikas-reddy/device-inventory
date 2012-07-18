class Request < ActiveRecord::Base
  attr_accessible :device_id, :owner, :requestor
  belongs_to :device

  def self.count_for(username)
    Request.where(owner: username).count
  end
end
