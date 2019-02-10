module Writers
  class Base
    def initialize(filename: '')
      @filename = filename
    end

    def append(row = [])
      raise NotImplementedError
    end

    def save
      raise NotImplementedError
    end

    private

    def complete_filename
      "#{@filename}.#{file_extension}"
    end

    def file_extension
      raise NotImplementedError
    end
  end
end
