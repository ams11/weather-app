require 'httparty'

class WeatherService
  def initialize(app_id)
    @app_id = app_id
  end

  def retrieve_weather(latitude:, longitude:)
    forecast_url = "https://api.openweathermap.org/data/2.5/weather?lat=#{latitude}&lon=#{longitude}&appid=#{@app_id}"
    HTTParty.get(forecast_url)
  end
end