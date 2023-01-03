module ForecastsHelper
  include ActionView::Helpers::DateHelper

  def forecast_info_from_forecast_data(forecast_data)
    {
      cached: !!forecast_data[:cached] ? time_ago_in_words(forecast_data[:cached]) : nil,
      location: forecast_data["name"],
      temperature: forecast_data["main"]["temp"],
      conditions: forecast_data["weather"].first["main"],
      wind: "#{forecast_data['wind']['speed']} miles per hour at #{forecast_data['wind']['deg']} degrees"
    }
  end
end