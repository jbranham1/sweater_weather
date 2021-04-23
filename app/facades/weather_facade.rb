class ForecastFacade
  def self.get_forecast(location)
    location = MapquestService.find_coordinal_location(params[:location])
    forecast = WeatherService.find_weather(location)

    return forecast = {} if forecast == {}
    yard_info = yard_info(booking[:attributes][:yard_id])
    OpenStruct.new({ id:           booking[:id],
                     yard_id:      booking[:attributes][:yard_id],
                     yard_name:    yard_info[:attributes][:name],
                     status:       booking[:attributes][:status],
                     name:         booking[:attributes][:booking_name],
                     address:      full_address(yard_info),
                     date:         booking[:attributes][:date].to_date,
                     time:         get_time(booking),
                     duration:     booking[:attributes][:duration],
                     description:  booking[:attributes][:description],
                     total_cost:   total_cost(booking[:attributes][:duration], yard_info[:attributes][:price]),

                     coords: get_coords(full_address(yard_info)) })
  end
end
