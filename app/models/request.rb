class Request < ActiveRecord::Base
  attr_accessible :device_id, :owner, :requestor

  # Associations
  belongs_to :device

  # Scopes
  scope :pending, where(state: :pending)

  # Callback
  after_create :send_request_email

  # State Machine
  state_machine :state, :initial => :pending do
    event :reject, :approve do
      transition :pending => :archived
    end
  end

  def reject_with_reason(reason)
    self.reject
    DeviceMailer.rejection_email(self.owner, self.requestor, self.device, reason).deliver
  end

  def self.pending_count(username)
    Request.pending.where(owner: username).count
  end

  private

  def send_request_email
    DeviceMailer.request_email(self.owner, self.requestor, self.device).deliver
  end

end
