class HourlyWeatherSerializer
  include FastJsonapi::ObjectSerializer
  attributes :time, :temperature, :conditions, :icon
end
