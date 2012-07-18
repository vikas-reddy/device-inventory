class Request < ActiveRecord::Base
  attr_accessible :device_id, :owner, :requestor
  belongs_to :device

  # Callback
  after_create :send_request_email

  def self.count_for(username)
    Request.where(owner: username).count
  end

  private

  def send_request_email
    DeviceMailer.request_email(self.owner, self.requestor, self.device).deliver
  end

end
