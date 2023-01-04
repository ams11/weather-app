class ForecastRetriever
  include GeolocateService

  def retrieve_forecast(address:)
    parsed_address = parse_address(address: address)
    zipcode = parsed_address.components["postal_code"][0]

    forecast = WeatherForecast.find_by(zipcode: zipcode)
    if forecast.nil? || forecast.expired?
      forecast_data = weather_service.retrieve_weather(latitude: parsed_address.latitude, longitude: parsed_address.longitude)
      if forecast
        forecast.update!(forecast_data: forecast_data)
      else
        WeatherForecast.create!(zipcode: zipcode, forecast_data: forecast_data)
      end
    end

    zipcode
  end

  def parse_address(address:)
    result = geocode_address(address: address)
    if result.components["postal_code"].nil?
      result = geocode_address(address: "#{result.latitude}, #{result.longitude}")
    end

    result
  end

  private

  def weather_service
    @weather_service ||= WeatherService.new(WeatherApp::Application.config.open_weather_map_api_key)
  end
end