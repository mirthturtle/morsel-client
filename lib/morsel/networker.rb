require 'httparty'

class Networker
  @@prod_base = "https://www.christiandewolf.com/"
  @@dev_base  = "http://localhost:3000/"

  @@morsel_path = "m3lon/morsels.json"
  @@up_path     = "m3lon/morsels/up.json"

  @@morsel_code = ENV['MORSEL_CODE']

  def initialize(prod = false)
    @morsel_url = (prod ? @@prod_base : @@dev_base) + @@morsel_path
    @up_url     = (prod ? @@prod_base : @@dev_base) + @@up_path
    @session = nil
  end

  # checks if the service is up
  def up
    response = HTTParty.get( @up_url )
    response.code == 200
  end

  def create_morsel(content)
    response = HTTParty.post( @morsel_url, body: {m3lon_morsel: {content: content}, morsel_code: @@morsel_code } )
    resp = JSON.parse( response.body )
    resp['errors']
  end

end
