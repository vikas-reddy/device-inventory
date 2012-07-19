class RequestsController < ApplicationController
  before_filter :login_required

  def index
    @requests = Request.where(owner: current_user)
  end

  def approve
    @req = Request.find(params[:id])
    device = @req.device

    respond_to do |format|
      if device.assign_to(@req.requestor)
        DeviceMailer.approval_email(@req.owner, @req.requestor, @req.device).deliver
        @req.destroy
        format.html { redirect_to requests_path, notice: "Successfully approved the request and an email has been sent to `#{device.possessor}`" }
      else
        format.html { redirect_to requests_path, notice: "Unable to approve the request" }
      end
    end
  end

  def reject
    @req = Request.find(params[:id])
    device = @req.device

    respond_to do |format|
      if device.deny
        @req.destroy
        format.html { redirect_to requests_path, notice: "Successfully rejected the request" }
      else
        format.html { redirect_to requests_path, notice: "Unable to reject the request" }
      end
    end
  end
end
