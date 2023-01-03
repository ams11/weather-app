class ForecastsController < ApplicationController
  before_action :load_forecast

  def show
    render "show", locals: { forecast: @forecast }
  end

  def new
    render "new"
  end

  def update
    forecast = WeatherForecast.retrieve(weather_forecast_params.fetch(:zipcode))
    redirect_to forecast_path(forecast)
  end

  private

  def load_forecast
    @forecast = WeatherForecast.find(params.permit(:id).fetch(:id))
  end

  def weather_forecast_params
    params.require(:weather_forecast).permit(:zipcode)
  end
end