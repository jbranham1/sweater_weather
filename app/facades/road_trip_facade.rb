class RoadTripFacade
  def self.get_route(origin, destination)
    trip = MapquestService.find_directions(origin, destination)
    Roadtrip.new(trip, origin, destination)
  end
end
