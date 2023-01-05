# Weather App

Installation and running instructions:
 - You will need Ruby 3.0.0. If using rvm, or similar manager, you may be able to run something like `rvm install 3.0.0` to install it.
 - install bundler `gem install bundle`
 - install dependencies: `bundle install`
 - the app uses the Sqlite database, make sure it's installed, then 
 - create and initialize your database: `rails db:create db:migrate`
 - create a `.env` file for storing secrets (you can copy the included `.env_sample`) and populate it with your keys for https://openweathermap.org/api and https://console.cloud.google.com/google/maps-apis/overview
 - start the server locally: `rails s`
 - you can now navigate to the home page at `http://localhost:3000` and enter an address to get a weather forecast

Application notes:
 - you can enter any address, the app uses the Google Maps API to parse and geolocate it and correlate with a zipcode (or postal code if international). Addresses that cannot be parsed, or resolve to a location without a postal code (e.g. Antarctica, but also certain countries including Ireland and Mongolia) are rejected. The app then retrieves the weather for the selected location and redirects to a page for showing it, with the url key-ed off the zipcode.
 - the weather info is re-used for any additional requests that resolve to that same zipcode for the next 30 minutes (and labeled as cached). After 30 minutes, the cache is expired, and the next request will query the weather again.
 - the code for retrieving 7-day (up to 16 really) forecast is included, but requires a paid subscription to openweathermap.org, so I have not tested it so far.
 - the standard workflow is to enter the address for the weather information on the home page, which will then retrieve the weather info and redirect the user to the display page. Alternatively, it's possible to navigate directly to the display page (e.g. http://localhost:3000/forecasts/90210), without first having queried for the weather for that zipcode, and the app will automatically retrieve weather info (assuming a valid zipcode)
 - since the system supports global addresses and forecast, it is, theoretically possible to have a conflict, if there is zipcode/postal code that's used in more than one location around the world. When the first one is queried, we'll get its postal code and create a record with the weather for it. When the second one is requested, if the resulting postal code looks the same, we'll just re-use the existing cached result.

Testing:
 Unfortunately, I did not have time to include tests with the project at this point, but normally there would be model, helper, and integration tests under `/test`. I tend to lean towards Minitest for tests, though RSpec also works. 