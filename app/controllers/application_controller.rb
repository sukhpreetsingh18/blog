# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_cache_headers

  private

  def set_cache_headers
    response.headers['Cache-Control'] = 'no-cache, no-store'
    response.headers['Pragma'] = 'no-cache'
  end
end
