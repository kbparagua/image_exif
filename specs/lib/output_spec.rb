require_relative '../spec_helper'
require "#{APP_ROOT}/lib/output"
require "#{APP_ROOT}/lib/image_data"

RSpec.describe Output do
  let (:image_data){ ImageData.new("#{SPECS_PATH}/fixtures/00.jpg") }

  describe '#append(image_data)' do
    let (:output){ described_class.new }
    let! (:initial_row_count){ output.rows.length }

    it 'appends a new row' do
      output.append(image_data)
      expect(output.rows.length).to eq initial_row_count + 1
    end
  end

  shared_examples 'a file writer' do |output_format|
    let (:file){ "#{APP_ROOT}/test.#{output_format}"}
    let (:output){ described_class.new(filename: 'test', format: output_format) }

    before do
      output.append(image_data)
      output.save
    end

    after do
      File.delete(file) if File.exist?(file)
    end

    it 'creates a file' do
      expect(File).to exist(file)
    end
  end

  describe '#save' do
    context 'when format is csv' do
      it_behaves_like 'a file writer', 'csv'
    end

    context 'when format is html' do
      it_behaves_like 'a file writer', 'html'
    end
  end
end
