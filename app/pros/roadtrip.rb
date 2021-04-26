class Roadtrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(data)
    @id = nil
    @start_city = get_address(data[:route][:locations].first)
    @end_city = get_address(data[:route][:locations].last)
    @travel_time = data[:route][:formattedTime]
    @weather_at_eta = get_weather(data)
  end

  def get_address(location)
    "#{location[:street]} #{location[:adminArea5]}, #{location[:adminArea3]} #{location[:postalCode]}"
  end

  def get_weather(trip)
    forecast = WeatherService.find_weather(trip[:route][:boundingBox][:lr])
    time_split = trip[:route][:formattedTime].split(":")

    if time_split[0].to_i <= 48
      arrival_time = alter_date(trip[:route][:formattedTime])
      arrival_forecast = forecast[:hourly].find {|h| h[:dt] == arrival_time.to_i }
      temp = arrival_forecast[:temp]
    else
      arrival_date = alter_date(trip[:route][:formattedTime], false)
      arrival_forecast = forecast[:daily].find {|h| h[:dt] == arrival_date.to_i }
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
      DateTime.new(date.year, date.month, date.day, 12,0,0,"-5:00")
    end
  end
end
