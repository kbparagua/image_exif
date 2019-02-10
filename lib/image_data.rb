require 'mini_magick'

class ImageData
  class ImageNotFoundError < StandardError; end

  attr_reader :path

  def initialize(absolute_path = '')
    @path = absolute_path
    raise ImageNotFoundError, "#{path} not found" unless File.file?(path)
  end

  def filename
    @filename ||= File.basename(path)
  end

  def dimensions
    if image.dimensions
      image.dimensions.join(' x ')
    else
      ''
    end
  end

  def gps_latitude
    get('GPSLatitude')
  end

  def gps_latitude_ref
    get('GPSLatitudeRef')
  end

  def gps_longitude
    get('GPSLongitude')
  end

  def gps_longitude_ref
    get('GPSLongitudeRef')
  end

  def gps_altitude_ref
    get('GPSAltitudeRef')
  end

  def gps_datestamp
    get('GPSDateStamp')
  end

  def gps_img_direction_ref
    get('GPSImgDirectionRef')
  end

  def gps_info
    get('GPSInfo')
  end

  def gps_map_datum
    get('GPSMapDatum')
  end

  def gps_satellites
    get('GPSSatellites')
  end

  def gps_timestamp
    get('GPSTimeStamp')
  end

  private

  def get(field)
    value = image.exif[field]
    value ? value.strip : ''
  end

  def image
    @image ||= MiniMagick::Image.new(path)
  end
end
