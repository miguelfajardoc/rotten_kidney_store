class Shop::BaseController < ApplicationController
  allow_unauthenticated_access
  layout "shop"
end
