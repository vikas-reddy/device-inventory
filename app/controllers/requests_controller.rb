class RequestsController < ApplicationController
  before_filter :login_required

  def index
    @requests = Request.pending.where(owner: current_user)
  end

  def approve
    @req = Request.find(params[:id])

    respond_to do |format|
      if @req.approve
        format.html { redirect_to requests_path, notice: "Successfully approved the request and an email has been sent to `#{@req.requestor}`" }
      else
        format.html { redirect_to requests_path, notice: "Unable to approve the request" }
      end
    end
  end

  def reject
    @req = Request.find(params[:id])

    respond_to do |format|
      if @req.reject
        format.html { redirect_to requests_path, notice: "Successfully rejected the request" }
      else
        format.html { redirect_to requests_path, notice: "Unable to reject the request" }
      end
    end
  end
end
