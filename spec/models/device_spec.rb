require 'spec_helper'

describe Device do

  describe '#attributes and methods' do
    it { should validate_presence_of(:serial_num) }

    it "validate uniqueness of serial number" do
      device = FactoryGirl.create(:device)
      should validate_uniqueness_of(:serial_num)
    end

    describe '#mac_addr' do
      before(:each) do
        @device = FactoryGirl.build(:device)
      end

      it "accept valid ones" do
        @device.mac_addr = '0a:1b:2c:3d:4e:5f'
        @device.should be_valid

        @device.mac_addr = '' # allow_blank
        @device.should be_valid
      end

      it "discard invalid ones" do
        @device.mac_addr = '0a:1b:2c:3d:xx:5f'
        @device.should_not be_valid
        @device.errors[:mac_addr].should include("should be 48-bit hexadecimal string")

        @device.mac_addr = '0a1b2c3d4e5f'
        @device.should_not be_valid
        @device.errors[:mac_addr].should include("should be 48-bit hexadecimal string")
      end
    end

    describe '#imei' do
      before(:each) do
        @device = FactoryGirl.build(:device)
      end

      it "accept valid ones" do
        @device.imei = '354354354354354'
        @device.should be_valid

        @device.imei = '35435435435435487'
        @device.should be_valid

        @device.imei = '' # allow_blank
        @device.should be_valid
      end

      it "discard invalid ones" do
        @device.imei = '5675abc67def567'
        @device.should_not be_valid
        @device.errors[:imei].should include("should be 15 or 17-digit")

        @device.imei = '0a1b2c3d4e5f'
        @device.should_not be_valid
        @device.errors[:imei].should include("should be 15 or 17-digit")
      end
    end

    describe '#phone_num' do
      before(:each) do
        @device = FactoryGirl.build(:device)
      end

      it "accept valid ones" do
        @device.phone_num = '9292929292'
        @device.should be_valid

        @device.phone_num = '' # allow_blank
        @device.should be_valid
      end

      it "discard invalid ones" do
        @device.phone_num = '0929292929'
        @device.should_not be_valid
        @device.errors[:phone_num].should include("should be 10-digit")

        @device.phone_num = '0a1b2c3d4e5f'
        @device.should_not be_valid
        @device.errors[:phone_num].should include("should be 10-digit")
      end
    end
  end

  describe '#associations' do
    it { should have_many(:accessories) }
    it { should have_many(:requests) }
    it { should have_many(:events) }
    it { should belong_to(:device_type) }
  end

  describe '#instance methods' do
    it '#os_name' do
      @device = FactoryGirl.build(:device, os: 'iOS', os_version: '4.2')
      @device.os_name.should == 'iOS (4.2)'
    end

    it '#assign_to' do
      @device = FactoryGirl.create(:device, state: 'available', possessor: nil)
      @device.should be_available
      @device.ask
      @device.assign_to('bob')
      @device.possessor.should == 'bob'
      @device.should be_in_use
    end
  end
end
