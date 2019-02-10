require 'csv'
require_relative './writers/csv'
require_relative './writers/html'

class Output
  FIELDS = [
    [:filename, 'Filename'],
    [:dimensions, 'Dimensions'],
    [:gps_info, 'GPS Info'],
    [:gps_latitude, 'GPS Latitude'],
    [:gps_latitude_ref, 'GPS Latitude Ref'],
    [:gps_longitude, 'GPS Longitude'],
    [:gps_longitude_ref, 'GPS Longitude Ref'],
    [:gps_altitude_ref, 'GPS Altitude Ref'],
    [:gps_timestamp, 'GPS Time Stamp'],
    [:gps_satellites, 'GPS Satellites'],
    [:gps_img_direction_ref, 'GPS Img Direction Ref'],
    [:gps_map_datum, 'GPS Map Datum'],
    [:gps_datestamp, 'GPS Date Stamp']
  ]

  WRITER_CLASSES = {
    csv: Writers::Csv,
    html: Writers::Html
  }

  def self.write(format: 'csv', filename: 'output', &block)
    self.new(format: format, filename: filename, &block)
  end

  def initialize(format: 'csv', filename: 'output')
    @format = format
    @filename = filename

    if block_given?
      yield(self)
      save
    end
  end

  def append(image_data)
    rows.push as_row(image_data)
  end

  def save
    rows.each { |row| writer.append(row) }
    writer.save
  end

  def rows
    @rows ||= [headers]
  end

  private

  def as_row(image_data)
    FIELDS.map do |field|
      attribute = field.first
      image_data.send(attribute).strip
    end
  end

  def headers
    FIELDS.map(&:last)
  end

  def writer
    @writer ||= WRITER_CLASSES[@format.downcase.to_sym].new(filename: @filename)
  end
end
