class Shop::ProductsController < Shop::BaseController
  def index
    @products = Product.includes(:character, :product_kind, images_attachments: :blob).order(created_at: :desc)
    @products = @products.where(product_kind_id: params[:product_kind_id]) if params[:product_kind_id].present?
    @products = @products.where(character_id: params[:character_id]) if params[:character_id].present?

    @active_product_kind = @shop_product_kinds.find { |kind| kind.id.to_s == params[:product_kind_id].to_s }
    @active_character = @shop_characters.find { |character| character.id.to_s == params[:character_id].to_s }
  end

  def show
    @product = Product.includes(:character, :product_kind, images_attachments: :blob).find(params[:id])
  end
end
