class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        attach_new_images
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        attach_new_images
        remove_selected_images
        format.html { redirect_to @product, notice: "Product was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, notice: "Product was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params.expect(:id))
    end

    # Append newly uploaded images without replacing the existing ones.
    # In Rails 8 assigning to a has_many_attached always replaces, so images
    # are attached explicitly here instead of going through mass assignment.
    def attach_new_images
      files = Array(params.dig(:product, :images)).reject(&:blank?)
      @product.images.attach(files) if files.any?
    end

    # Purge attachments the user checked "Remove" on in the edit form.
    def remove_selected_images
      ids = Array(params[:remove_image_ids]).reject(&:blank?)
      @product.images_attachments.where(id: ids).find_each(&:purge_later) if ids.any?
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.expect(product: [ :stock, :price, :cost, :aditional_info, :character_id, :product_kind_id ])
    end
end
