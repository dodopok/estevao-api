Rswag::Api.configure do |c|
  # Specify a root folder where Swagger JSON files are located
  # This is used by the Swagger middleware to serve requests for API descriptions
  # NOTE: If you're using rswag-specs to generate Swagger, you'll need to ensure
  # that it's configured to generate files in the same folder
  c.openapi_root = Rails.root.to_s + "/swagger"

  # Inject a lambda function to alter the returned Swagger prior to serialization
  # The function will have access to the rack env for the current request
  # For example, you could leverage this to dynamically assign the "host" property
  #
  c.swagger_filter = lambda { |swagger, env|
    # Show only the appropriate server based on environment
    if Rails.env.production?
      swagger["servers"] = [
        {
          "url" => "https://api.caminhoanglicano.com.br",
          "description" => "Production server"
        }
      ]
    else
      swagger["servers"] = [
        {
          "url" => "http://localhost:3000",
          "description" => "Development server"
        }
      ]
    end
  }
end
