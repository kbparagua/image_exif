require_relative '../spec_helper.rb'
require "#{APP_ROOT}/lib/image_data"

RSpec.describe ImageData do

  context 'when invalid path' do
    describe '.new(path)' do
      it 'raises an error' do
        expect { described_class.new("not-existing.jpg") }.to raise_error ImageData::ImageNotFoundError
      end
    end
  end

  context 'when valid path' do
    let (:data){ described_class.new("#{SPECS_PATH}/fixtures/00.jpg") }

    describe '#filename' do
      subject { data.filename }
      it { is_expected.to eq '00.jpg' }
    end

    describe '#dimensions' do
      subject { data.dimensions }
      it { is_expected.to eq '640 x 480' }
    end

    describe '#gps_latitude' do
      subject { data.gps_latitude }
      it { is_expected.to eq '43/1, 28/1, 281400000/100000000' }
    end

    describe '#gps_latitude_ref' do
      subject { data.gps_latitude_ref }
      it { is_expected.to eq 'N' }
    end

    describe '#gps_longitude' do
      subject { data.gps_longitude }
      it { is_expected.to eq '11/1, 53/1, 645599999/100000000' }
    end

    describe '#gps_longitude_ref' do
      subject { data.gps_longitude_ref }
      it { is_expected.to eq 'E' }
    end

    describe '#gps_altitude_ref' do
      subject { data.gps_altitude_ref }
      it { is_expected.to eq '0' }
    end

    describe '#gps_datestamp' do
      subject { data.gps_datestamp }
      it { is_expected.to eq '2008:10:23' }
    end

    describe '#gps_img_direction_ref' do
      subject { data.gps_img_direction_ref }
      it { is_expected.to eq '' }
    end

    describe '#gps_info' do
      subject { data.gps_info }
      it { is_expected.to eq '926' }
    end

    describe '#gps_map_datum' do
      subject { data.gps_map_datum }
      it { is_expected.to eq 'WGS-84' }
    end

    describe '#gps_satellites' do
      subject { data.gps_satellites }
      it { is_expected.to eq '06' }
    end

    describe '#gps_timestamp' do
      subject { data.gps_timestamp }
      it { is_expected.to eq '14/1, 27/1, 724/100' }
    end
  end
end
