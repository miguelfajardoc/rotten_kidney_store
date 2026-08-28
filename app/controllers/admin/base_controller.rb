class Admin::BaseController < ApplicationController
  # Authentication is already required for every controller through
  # ApplicationController's `before_action :require_authentication`, so the
  # whole admin area is protected by the session/login flow.
  layout "admin"
end
