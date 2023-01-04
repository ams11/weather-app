class ForecastsController < ApplicationController
  include ForecastsHelper

  before_action :validate_forecast, only: :show
  after_action :mark_as_cached, only: :show

  def show
    render "show", locals: { forecast_info: forecast_info_from_forecast_data(forecast) }
  end

  def new
    forecast = WeatherForecast.new
    render "new", locals: { forecast: forecast }
  end

  def create
    forecast_retriever = ForecastRetriever.new
    zipcode = forecast_retriever.retrieve_forecast(address: weather_forecast_params.fetch(:address))
    redirect_to forecast_path(zipcode)
  end

  private

  def validate_forecast
    unless forecast
      flash[:error] = "Forecast not found"

      redirect_to new_forecast_path
    end
  end

  def mark_as_cached
    # cheat a little bit and don't change the updated_at date here, so we can accurately track when forecasts expire
    forecast.update!(cached: true, updated_at: forecast.updated_at)
  end

  def forecast
    @forecast ||= WeatherForecast.recent.find_by(zipcode: forecast_zipcode_param)
  end

  def forecast_zipcode_param
    params.permit(:id).fetch(:id)
  end

  def weather_forecast_params
    params.require(:weather_forecast).permit(:address)
  end
end