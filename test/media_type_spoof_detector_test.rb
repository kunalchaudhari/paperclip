require './test/helper'

class MediaTypeSpoofDetectorTest < Test::Unit::TestCase
  should 'reject a file that is named .html and identifies as PNG' do
    file = File.open(fixture_file("5k.png"))
    assert Paperclip::MediaTypeSpoofDetector.using(file, "5k.html").spoofed?
  end

  should 'not reject a file that is named .jpg and identifies as PNG' do
    file = File.open(fixture_file("5k.png"))
    assert ! Paperclip::MediaTypeSpoofDetector.using(file, "5k.jpg").spoofed?
  end

  should 'not reject a file that is named .html and identifies as HTML' do
    file = File.open(fixture_file("empty.html"))
    assert ! Paperclip::MediaTypeSpoofDetector.using(file, "empty.html").spoofed?
  end

  should 'not reject a file that does not have a name' do
    file = File.open(fixture_file("empty.html"))
    assert ! Paperclip::MediaTypeSpoofDetector.using(file, "").spoofed?
  end

  should 'not reject when the supplied file is an IOAdapter' do
    adapter = Paperclip.io_adapters.for(File.new(fixture_file("5k.png")))
    assert ! Paperclip::MediaTypeSpoofDetector.using(adapter, adapter.original_filename).spoofed?
  end
end
