require 'nokogiri'

class SuuntoDevice
  def initialize(document)
    @document = document
  end

  def parse(hash)
    @document.root.css('Device').each do |tag|
      hash[:name] = tag.css('Name').text
      hash[:serial_number] = tag.css('SerialNumber').text
      hash[:sw] = tag.css('SW').text
      hash[:hw] = tag.css('HW').text
      hash[:bsl] = tag.css('BSL').text
    end
    hash
  end
end
