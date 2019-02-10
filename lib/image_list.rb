require 'filemagic'

class ImageList
  class DirectoryNotFound < StandardError; end

  def initialize(directory = '')
    @directory = directory
  end

  def each
    raise DirectoryNotFound, "#{@directory} not found" unless File.directory?(@directory)

    get_images(@directory).each do |absolute_filename|
      yield(absolute_filename)
    end
  end

  def get_images(path = '')
    if File.directory?(path)
      get_images_from_directory(path)
    elsif image?(path)
      [path]
    else
      []
    end
  end

  private

  def get_images_from_directory(path = '')
    images = []

    Dir.foreach(path) do |filename|
      next if ['.', '..'].include?(filename)
      images += get_images("#{path}/#{filename}")
    end

    images
  end

  def image?(filename = '')
    mime_type = filemagic.file(filename, true)
    mime_type.start_with?('image')
  end

  def filemagic
    @filemagic ||= FileMagic.mime
  end
end
