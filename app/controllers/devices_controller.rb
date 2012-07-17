class DevicesController < ApplicationController
  before_filter :login_required
  before_filter :admin_required, only: [:new, :create, :edit, :update, :destroy]

  # before_filter :admin_required, only: [:make_available, :make_unavailable]
  # before_filter :owner_required, only: [:reject, :approve]

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
    respond_to do |format|
      format.pdf
      format.xls {
        devices = Spreadsheet::Workbook.new
        list = devices.create_worksheet :name => 'devices_list'
        list.row(0).concat %w{Make Model SerialNumber Os OsVersion Environment Project Status Provider Phone MACID IPADDR Property Of AssignedTo} 
        @devices.each_with_index { |device, i|
          list.row(i+1).push device.make,device.model,device.serial_num,device.os,device.os_version,device.environment,device.project,device.state,
            device.service_provider,device.phone_num,device.mac_addr,device.ip_addr,device.property_of
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
  
  #Import Devices Data from Excel
  def import
    if params[:device_import_file]
      imp_filename = params[:device_import_file].tempfile.path
      Spreadsheet.open(imp_filename) do |device|
        device.worksheet('Sheet1').each do |row|
          d = Device.new
          #break if row[0].nil?
          d.serial_num = row[1]
          d.make = row[2]
          d.model = row[3]
          d.os = row[4]
          d.os_version = row[5]
          d.environment = row[6]
          d.project = row[7]
          d.service_provider = row[8]
          d.phone_num = row[9].to_i.to_s
          d.mac_addr = row[10]
          d.ip_addr = row[11]
          d.property_of = row[14]
          d.status = "available"
          puts "######################################"
          logger.info d.inspect  
          puts "######################################"
          d.save
          puts "######################################"
          logger.info d.errors.inspect  
          puts "######################################"
        end
      end
      flash.now[:message]="Import Successful, new records added to data base"
    else
      flash.now[:notice] = "No filename given"
    end
    respond_to do |format|
      format.html { redirect_to devices_url }
      format.json { head :no_content }
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

  # POST /devices/:id/ask
  def ask
    @device = Device.find(params[:id])

    respond_to do |format|
      if @device.request
        format.json { render json: {status: 'success', id: @device.id, notice: 'Sent a request successfully.'} }
      else
        format.json { render json: {status: 'failure', notice: 'Unable to add a request.'} }
      end
    end
  end

  def reject
  end

  def approve
  end

  def return
  end

  def make_unavailable
  end

  def make_available
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
