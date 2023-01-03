class WeatherForecast < ApplicationRecord
  CACHE_LIMIT_IN_MINUTES = 30.minutes

  scope :recent, -> { where("created_at > ?", DateTime.now - CACHE_LIMIT_IN_MINUTES) }
  scope :expired, -> { where("created_at < ?", DateTime.now - CACHE_LIMIT_IN_MINUTES) }

  def self.retrieve(zipcode)
    cached_forecast = WeatherForecast.recent.find_by(zipcode: zipcode)
    if cached_forecast
      cached_forecast.forecast_data.merge(cached: true)
    else
      forecast_data = weather_service.retrieve_weather(zipcode)
      WeatherForecast.create!(zipcode: zipcode, forecast_data: forecast_data)
      forecast_data
    end
  end

  private

  def self.weather_service
    @weather_service ||= WeatherService.new(WeatherApp::Application.config.open_weather_map_api_key)
  end
end