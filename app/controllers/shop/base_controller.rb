class Shop::BaseController < ApplicationController
  allow_unauthenticated_access
  layout "shop"

  before_action :load_shop_filters

  private

  def load_shop_filters
    @shop_product_kinds = ProductKind.order(:name)
    @shop_characters = Character.order(:name)
  end
end
