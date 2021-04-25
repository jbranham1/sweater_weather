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
      split = trip[:route][:formattedTime].split(":")
      "#{split[0]} hours, #{split[1]} minutes"
    else
      "impossible route"
    end
  end

  def self.get_weather(trip)
    if trip[:info][:messages].blank?
      forecast = WeatherService.find_weather(trip[:route][:boundingBox][:lr])
      time_split = trip[:route][:formattedTime].split(":")
      if time_split[0].to_i <= 48
        arrival_time = alter_date(time_split)
        arrival_forecast = forecast[:hourly]
          .select {|h| h[:dt] == arrival_time.to_i }
          .first
        temp = arrival_forecast[:temp]
      else
        arrival_date = alter_date(time_split, false)
        arrival_forecast = forecast[:daily]
          .select {|h| h[:dt] == arrival_date.to_i }
          .first
        temp = arrival_forecast[:temp][:day]
      end
      {
        temperature: temp,
        conditions: arrival_forecast[:weather].first[:description]
      }
    else
      {}
    end
  end

  def self.alter_date(time_split, hourly = true)
    date = DateTime.now + time_split[0].to_i.hours + time_split[1].to_i.minutes + time_split[2].to_i.seconds
    if hourly
      DateTime.new(date.year, date.month, date.day, date.hour,0,0,"-5:00")
    else
      DateTime.new(date.year, date.month, date.day, 12,0,0,"-5:00")
    end
  end
end
