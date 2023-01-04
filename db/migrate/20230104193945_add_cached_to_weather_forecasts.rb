class AddCachedToWeatherForecasts < ActiveRecord::Migration[7.0]
  def change
    change_table :weather_forecasts do |t|
      t.boolean :cached, null: false, default: false
    end
  end
end
