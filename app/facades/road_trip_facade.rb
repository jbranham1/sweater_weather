class RoadTripFacade
  def self.get_route(origin, destination)
    trip = MapquestService.find_directions(origin, destination)

    if trip[:info][:messages].blank?
      Roadtrip.new(trip)
    else
      OpenStruct.new({
                      start_city: origin.titleize,
                      end_city: destination.titleize,
                      travel_time: "impossible route",
                      weather_at_eta: {}
                    })
    end
  end
end
