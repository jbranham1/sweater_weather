class RoadTripFacade
  def self.get_route(origin, destination)
    trip = MapquestService.find_directions(origin, destination)
    return trip if trip == {}

    OpenStruct.new({
                    start_city: origin.titleize,
                    end_city: destination.titleize,
                    travel_time: get_travel_time(trip),
                    weather_at_eta: get_weather(trip)
                  })
  end

  def self.get_travel_time(trip)
    if trip[:info][:messages].blank?
      trip[:route][:formattedTime]
    else
      "impossible"
    end
  end

  def self.get_weather(trip)
    if trip[:info][:messages].blank?
      #forecast = WeatherService.find_weather_at_time(trip[:route][:boundingBox][:ul],trip[:route][:formattedTime])
      {
        temperature: 59.4,
        conditions: "test"
      }
    else
      {}
    end
  end
end
