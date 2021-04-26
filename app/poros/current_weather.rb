class CurrentWeather
  attr_reader :datetime,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon

  def initialize(data)
    @datetime =    Time.at(data[:dt]).strftime("%F %T %z")
    @sunrise =     Time.at(data[:sunrise]).strftime("%F %T %z")
    @sunset =      Time.at(data[:sunset]).strftime("%F %T %z")
    @temperature = data[:temp]
    @feels_like  = data[:feels_like]
    @humidity =    data[:humidity]
    @uvi =         data[:uvi]
    @visibility =  data[:visibility]
    @conditions =  data[:weather].first[:description]
    @icon =        data[:weather].first[:icon]
  end
end
