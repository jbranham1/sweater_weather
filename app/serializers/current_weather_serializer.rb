class CurrentWeatherSerializer
  include FastJsonapi::ObjectSerializer
  attributes :datetime,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility, 
              :conditions,
              :icon
end
