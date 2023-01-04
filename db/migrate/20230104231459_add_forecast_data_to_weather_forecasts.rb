class AddForecastDataToWeatherForecasts < ActiveRecord::Migration[7.0]
  def change
    change_table :weather_forecasts do |t|
      t.json :upcoming_forecast_data
    end
  end
end
