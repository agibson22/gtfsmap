require 'net/http'

class MapController < ApplicationController
  include Transit_realtime
  def index
 	gtfs_rt_url = "http://api.octa.net/GTFSRealTime/protoBuf/VehiclePositions.aspx"

	data = Net::HTTP.get(URI.parse(gtfs_rt_url))
	feed = Transit_realtime::FeedMessage.decode(data)
	vehicle_hashes = []
	feed.entity[0..10].each do |v|
		if v.field?(:vehicle)
			vehicle_info = { 
				"id" => v.vehicle.vehicle.id,
				"lat" => v.vehicle.position.latitude,
				"long" => v.vehicle.position.longitude
				}
			vehicle_hashes << vehicle_info
		end
	end
	
	@vehicle_hashes = vehicle_hashes
  end
end
