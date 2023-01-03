class ForecastsController < ApplicationController
  include ForecastsHelper

  before_action :validate_forecast, only: :show

  def show
    render "show", locals: { forecast_info: forecast_info_from_forecast_data(forecast_data).merge(zipcode: forecast_zipcode_param) }
  end

  def new
    render "new"
  end

  def update
    forecast = WeatherForecast.retrieve(weather_forecast_params.fetch(:zipcode))
    redirect_to forecast_path(forecast)
  end

  private

  def validate_forecast
    unless forecast_data
      flash[:error] = "Forecast not found"

      redirect_to new_forecast_path
    end
  end

  def forecast_data
    @forecast_data ||= WeatherForecast.retrieve(forecast_zipcode_param)
  end

  def forecast_zipcode_param
    params.permit(:id).fetch(:id)
  end

  def weather_forecast_params
    params.require(:weather_forecast).permit(:zipcode)
  end
end