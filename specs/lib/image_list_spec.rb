require_relative '../spec_helper'
require "#{APP_ROOT}/lib/image_list"

FIXTURES_PATH = "#{SPECS_PATH}/fixtures"

RSpec.describe ImageList do
  describe '#each(&block)' do
    it 'yields the block' do
      expect { |block| described_class.new(FIXTURES_PATH).each(&block) }.to yield_control
    end

    context 'when invalid directory' do
      it 'raises an error' do
        expect { described_class.new('/invalid/path/here').each {} }.to raise_error ImageList::DirectoryNotFound
      end
    end
  end

  describe '#get_images(path)' do
    let (:images) do
      [
        '00.jpg',
        'heart.gif',
        'foo/02.jpg',
        'foo/baz/polo-enriquez-diwata.jpg',
        'foo/bar/01.jpg',
        'foo/bar/linux.png'
      ].map { |image| "#{FIXTURES_PATH}/#{image}" }
    end

    subject (:images){ described_class.new.get_images(FIXTURES_PATH) }
    it { is_expected.to match_array images }
  end
end
