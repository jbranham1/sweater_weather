class Roadtrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(data, origin, destination)
    @id = nil
    @start_city = origin.titleize
    @end_city = destination.titleize
    @travel_time = get_travel_time(data)
    @weather_at_eta = get_weather(data)
  end

  def get_travel_time(data)
    if data[:info][:messages].blank?
      data[:route][:formattedTime]
    else
      "impossible route"
    end
  end

  def get_weather(trip)
    return {} if !trip[:info][:messages].blank?
    forecast = WeatherService.find_weather(trip[:route][:boundingBox][:lr])
    time_split = trip[:route][:formattedTime].split(":")

    if time_split[0].to_i <= 48
      arrival_time = alter_date(trip[:route][:formattedTime])
      arrival_forecast = forecast[:hourly].find {|h| h[:dt] == arrival_time.to_i }
      temp = arrival_forecast[:temp]
    else

      arrival_date = alter_date(trip[:route][:formattedTime], false)
      arrival_forecast = forecast[:daily].find {|h| Time.at(h[:dt]).to_date == arrival_date.to_date }
      temp = arrival_forecast[:temp][:day]
    end
    {
      temperature: temp,
      conditions: arrival_forecast[:weather].first[:description]
    }
  end

  def alter_date(time, hourly = true)
    hours, minutes, seconds = time.split(":").map(&:to_f)
    date = DateTime.now + hours.hours + minutes.minutes + seconds.seconds
    if hourly
      DateTime.new(date.year, date.month, date.day, date.hour,0,0,"-5:00")
    else
      DateTime.new(date.year, date.month, date.day, 0,0,0,"-5:00")
    end
  end
end
