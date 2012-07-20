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
      format.xls do
        workbook = Spreadsheet::Workbook.new
        worksheet = workbook.create_worksheet(name: 'Devices List')
        worksheet.row(0).concat [
          'Make',
          'Model',
          'Serial Number',
          'OS',
          'OS Version',
          'Environment',
          'Project',
          'Status',
          'Provider',
          'Phone',
          'MAC Address',
          'IP Address',
          'Owner',
          'Possessor',
          'Property Of'
        ] 
        @devices.each_with_index { |device, i|
          worksheet.row(i+1).push(
            device.make,
            device.model,
            device.serial_num,
            device.os,
            device.os_version,
            device.environment,
            device.project,
            device.state,
            device.service_provider,
            device.phone_num,
            device.mac_addr,
            device.ip_addr,
            device.owner,
            device.possessor,
            device.property_of
          )
        }
        header_format = Spreadsheet::Format.new(color: :green, weight: :bold)
        worksheet.row(0).default_format = header_format
        #output to blob object
        blob = StringIO.new('')
        workbook.write(blob)
        #respond with blob object as a file
        send_data(blob.string, :type => "application/ms-excel", :filename => "Mobile Devices List.xls")
      end
    end
  end
  
  #Import Devices Data from Excel
  def import
    if params[:device_import_file]
      imp_filename = params[:device_import_file].tempfile.path
      Spreadsheet.open(imp_filename) do |spreadsheet|
        ws = spreadsheet.worksheets.first

        # No worksheets
        if ws.nil?
          flash[:error] = 'No worksheets in the Excel sheet provided'
        else
          ws.each do |row|
            d = Device.new
            #break if row[0].nil?
            d.serial_num       = row[1].strip
            d.make             = row[2].strip
            d.model            = row[3].strip
            d.os               = row[4].strip
            d.os_version       = row[5].strip
            d.environment      = row[6].strip
            d.project          = row[7].strip
            d.service_provider = row[8].strip
            d.phone_num        = ( row[9].blank? ? nil : row[9].to_i )
            d.mac_addr         = row[10].strip
            d.ip_addr          = row[11].strip
            d.property_of      = row[14].strip
            d.state            = :available
            d.save
          end
          flash[:notice] = 'Import successful, new records added to the database.'
        end
      end
    else
      flash[:error] = 'No file uploaded'
    end

    respond_to do |format|
      format.html { redirect_to devices_path }
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

  # PUT /devices/:id/ask.js
  def ask
    @device = Device.find(params[:id])

    if @device.ask
      req = Request.create(device_id: @device.id, requestor: current_user, owner: @device.owner)
      flash.now[:notice] = 'Sent a request successfully.'
    else
      flash.now[:error] = 'Unable to add a request.'
    end

    respond_to do |format|
      format.js
    end
  end

  # PUT /devices/:id/receive
  def receive
    @device = Device.find(params[:id])

    respond_to do |format|
      if @device.receive
        format.html { redirect_to @device, notice: 'Returned the device successfully. It\'s now available to other users' }
      else
        format.html { redirect_to @device, notice: 'Unable to receive the device' }
      end
    end
  end

  def make_unavailable
    @device = Device.find(params[:id])

    respond_to do |format|
      if @device.make_unavailable
        format.html { redirect_to edit_device_path, notice: 'The device is now marked unavailable to other users.' }
      else
        format.html { redirect_to edit_device_path, error: 'Unable to mark the device as unavailable.' }
      end
    end
  end

  def make_available
    @device = Device.find(params[:id])

    respond_to do |format|
      if @device.make_available
        format.html { redirect_to edit_device_path, notice: 'The device is now marked available to other users.' }
      else
        format.html { redirect_to edit_device_path, error: 'Unable to mark the device as available.' }
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
