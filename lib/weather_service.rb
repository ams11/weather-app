require 'httparty'

class WeatherService
  def initialize(app_id)
    @app_id = app_id
  end

  def retrieve_weather(latitude:, longitude:)
    forecast_url = "https://api.openweathermap.org/data/2.5/weather?lat=#{latitude}&lon=#{longitude}&appid=#{@app_id}&units=imperial"
    HTTParty.get(forecast_url)
  end

  def retrieve_weather_forecast(latitude:, longitude:, days: 7)
    # Note: this doesn't work with a free API kye for openweathermap, so I haven't had a chance to test it so far,
    # but including it in here as a proof of concept
    forecast_url = "https://api.openweathermap.org/data/2.5/forecast/daily?lat=#{latitude}&lon=#{longitude}&cnt=#{days}&appid=#{@app_id}&units=imperial"
    HTTParty.get(forecast_url)
  end
end