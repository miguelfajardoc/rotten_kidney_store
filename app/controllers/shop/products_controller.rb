class Shop::ProductsController < Shop::BaseController
  def index
    @products = Product.includes(:character, :product_kind, images_attachments: :blob).order(created_at: :desc)
  end

  def show
    @product = Product.includes(:character, :product_kind, images_attachments: :blob).find(params[:id])
  end
end
