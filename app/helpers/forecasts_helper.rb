module ForecastsHelper
  include ActionView::Helpers::DateHelper

  def forecast_info_from_forecast_data(weather_forecast)
    forecast_data = weather_forecast.forecast_data

    {
      cached: weather_forecast.cached? ? time_ago_in_words(weather_forecast.updated_at) : nil,
      zipcode: weather_forecast.zipcode,
      location: forecast_data["name"],
      temperature: forecast_data["main"]["temp"],
      conditions: forecast_data["weather"].first["main"],
      wind: "#{forecast_data['wind']['speed']} miles per hour at #{forecast_data['wind']['deg']} degrees",
      upcoming_weather_data: weather_forecast.upcoming_forecast_data,
    }
  end
end