Apipie.configure do |config|
  config.app_name                = "Organiser"
  config.app_info                = "Organiser"
  config.copyright               = "Organiser - 2018"
  config.default_version         = "1.0.0"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/api/apipie"
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.validate                = false
end
