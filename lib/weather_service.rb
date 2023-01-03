require 'httparty'

class WeatherService
  def initialize(app_id)
    @app_id = app_id
  end

  def retrieve_weather(zipcode)
    HTTParty.get("https://api.openweathermap.org/data/2.5/weather?q=#{zipcode}&appid=#{@app_id}&units=imperial")
  end
end