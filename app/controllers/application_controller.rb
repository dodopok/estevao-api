class ApplicationController < ActionController::API
  before_action :set_json_headers

  private

  def set_json_headers
    response.headers["Content-Type"] = "application/json; charset=utf-8"
    response.headers["Content-Disposition"] = "inline"
  end
end
