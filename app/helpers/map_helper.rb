module MapHelper
	def get_gtfs_rt

		gtfs_rt_url = "http://api.octa.net/GTFSRealTime/protoBuf/VehiclePositions.aspx"
		data = Net::HTTP.get(URI.parse(gtfs_rt_url))
		feed = Transit_realtime::FeedMessage.decode(data)
		for entity in feed.entity do
			if entity.field?(:vehicle)
				@trip_id = entity.vehicle.trip.trip_id
				@vehicle_id = entity.vehicle.vehicle.id
				@latitude = entity.vehicle.position.latitude
				@longitude = entity.vehicle.position.longitude
				@heading = entity.vehicle.position.bearing
			end
		end
	end
end
