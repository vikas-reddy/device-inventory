class RequestsController < ApplicationController
  before_filter :login_required

  def index
    @requests = Request.where(owner: current_user)
  end

  def approve
    @request = Request.find(params[:id])
    device = @request.device

    respond_to do |format|
      if device.approve and device.update_attributes(possessor: @request.requestor)
        @request.destroy
        format.html { redirect_to requests_path, notice: "You've successfully approved this request and an email has been sent to `#{device.possessor}`" }
      else
        format.html { redirect_to requests_path, notice: "Unable to approve this request" }
      end
    end
  end

  def reject
    @request = Request.find(params[:id])
    device = @request.device

    respond_to do |format|
      if device.reject
        @request.destroy
        format.html { redirect_to requests_path, notice: "You've successfully reject this request and an email has been sent to `#{device.possessor}`" }
      else
        format.html { redirect_to requests_path, notice: "Unable to reject this request" }
      end
    end
  end
end
