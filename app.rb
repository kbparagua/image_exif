require 'optparse'
require_relative 'lib/extract_image_info'

DEFAULT_OUTPUT_FORMAT = 'csv'

options = {}
OptionParser.new do |opts|
  opts.on('-f', '--format FORMAT', 'CSV or HTML'){ |value| options[:format] = value }
end.parse!

target_directory = ARGV.first
output_format = options[:format] || DEFAULT_OUTPUT_FORMAT

ExtractImageInfo.run(directory: target_directory, output_format: output_format)
