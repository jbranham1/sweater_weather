class DailyWeather
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon

  def initialize(data)
    @date =        Time.at(data[:dt]).to_date
    @sunrise =     Time.at(data[:sunrise]).strftime("%F %T %z")
    @sunset =      Time.at(data[:sunset]).strftime("%F %T %z")
    @max_temp =    data[:temp][:max]
    @min_temp =    data[:temp][:min]
    @conditions =  data[:weather].first[:description]
    @icon =        data[:weather].first[:icon]
  end
end
