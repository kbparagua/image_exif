require_relative 'image_data'
require_relative 'image_list'
require_relative 'output'

class ExtractImageInfo
  def self.run(directory: '.', output_format: 'csv')
    self.new(directory: directory, output_format: output_format).run
  end

  def initialize(directory: '.', output_format: 'csv')
    @directory = directory
    @output_format = output_format
  end

  def run
    Output.write(format: @output_format) do |output|
      ImageList.new(@directory).each do |path|
        data = ImageData.new(path)
        output.append(data)
      end
    end
  end
end
