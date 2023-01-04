class WeatherForecast < ApplicationRecord
  CACHE_LIMIT_IN_MINUTES = 30.minutes

  attr_accessor :address

  scope :recent, -> { where("updated_at > ?", DateTime.now - CACHE_LIMIT_IN_MINUTES) }
  scope :expired, -> { where("updated_at < ?", DateTime.now - CACHE_LIMIT_IN_MINUTES) }

  validates :zipcode, uniqueness: true

  def expired?
    updated_at < DateTime.now - CACHE_LIMIT_IN_MINUTES
  end

  def cached?
    updated_at < DateTime.now - 0.5.seconds
  end
end