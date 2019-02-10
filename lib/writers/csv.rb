require 'csv'
require_relative './base'

module Writers
  class Csv < Base
    def append(row = [])
      csv << row
    end

    def save
      csv.close
    end

    private

    def csv
      @csv ||= CSV.open(complete_filename, 'w')
    end

    def file_extension
      'csv'
    end
  end
end
