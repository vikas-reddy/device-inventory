class DevicesController < ApplicationController
  before_filter :login_required

  # GET /devices
  # GET /devices.json
  #
  def index
    @devices = Device.all(include: :device_type)
    respond_to do |format|
      format.html # index.html.erb 
      format.json { render json: @devices }
    end
  end

  # Exporting devices list to a Excel file
  def export
    @devices = Device.all
    require 'spreadsheet'
    respond_to do |format|
      format.pdf
      format.xls {
        devices = Spreadsheet::Workbook.new
        list = devices.create_worksheet :name => 'List of cliets'
        list.row(0).concat %w{Make Model SerialNumber Os OsVersion Environment Project Status Provider Phone MACID IPADDR AssignedTo} 
        @devices.each_with_index { |device, i|
          list.row(i+1).push device.make,device.model,device.serial_num,device.os,device.os_version,device.environment,device.project,device.status,
            device.service_provider,device.phone_num,device.mac_addr,device.ip_addr,
        }
        header_format = Spreadsheet::Format.new :color => :green, :weight => :bold
        list.row(0).default_format = header_format
        #output to blob object
        blob = StringIO.new('')
        devices.write(blob)
        #respond with blob object as a file
        send_data(blob.string, :type => "application/ms-excel", :filename => "device_list.xls")
      }
    end
  end


  # GET /devices/search
  # GET /devices/search.json
  def search
    @devices = Device.search(params[:q])

    respond_to do |format|
      format.html # search.html.erb
      format.json { render json: @devices }
    end
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
    @device = Device.find(params[:id])
    @accessory = Accessory.new
    @device_events = Version.where(item_id: @device.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @device }
    end
  end

  # GET /devices/new
  # GET /devices/new.json
  def new
    @device = Device.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @device }
    end
  end

  # GET /devices/1/edit
  def edit
    @device = Device.find(params[:id])

    respond_to do |format|
      format.html # edit.html.erb
      format.json { render json: @device }
    end
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(params[:device])

    respond_to do |format|
      if @device.save
        format.html { redirect_to @device, notice: 'Device was successfully created.' }
        format.json { render json: @device, status: :created, location: @device }
      else
        flash.now[:error] = "Some errors prevented the device from saving"
        format.html { render action: "new" }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /devices/1
  # PUT /devices/1.json
  def update
    @device = Device.find(params[:id])

    respond_to do |format|
      if @device.update_attributes(params[:device])
        format.html { redirect_to @device, notice: 'Device was successfully updated.' }
        format.json { head :no_content }
      else
        flash.now[:error] = "Some errors prevented the data from updating"
        format.html { render action: "edit" }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device = Device.find(params[:id])
    @device.destroy

    respond_to do |format|
      format.html { redirect_to devices_url }
      format.json { head :no_content }
    end
  end
end
