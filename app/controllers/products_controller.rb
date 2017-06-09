class ProductsController < ApplicationController


  def index
    #商品类型 ／ 品牌
    @category_groups = CategoryGroup.published
    @brands = Brand.published

    #判断是否选择分类
    if params[:category].present?
      @category_s = params[:category]
      @category = Category.find_by(name: @category_s)

      @products = Product.where(:category => @category.id).published.recent.paginate(:page => params[:page], :per_page => 12)

    #判断是否选择类型
    elsif params[:group].present?
      @group_s = params[:group]
      @group = CategoryGroup.find_by(name: @group_s)

      @products = Product.joins(:category).where("categories.category_group_id" => @group.id).published.recent.paginate(:page => params[:page], :per_page => 12)


    #判断是否筛选品牌
    elsif parama[:brand].present?
      @brand_s = params[:brand]
      @brand = Brand.find_by(name: @brand_s)

      @products = Product.where(:brand => @brand.id).published.recent.paginate(:page => params[:page], :per_page => 12)

    #p判断是否选择精选上屏
    elsif params[:chosen].present?
      @products = Product.where(:is_chosen => true).published.recent.paginate(:page => params[:page], :per_page => 12)

    #预设显示所有公开商品
    else
      @products = Product.published.recent.paginate(:page => params[:page], :per_page => 12)
    end
  end

      #@products = Product.all.order("position ASC") 这一行是教程里的代码

  def show
    @product = Product.find(params[:id])
    @product_images = @product.product_images.all
    @orderSum = OrderItem.where("product_id" => @product.id).sum(:quantity)
    @product_stock = @product.quantity - @orderSum

    #随机推荐3件商品
    @suggests = Product.published.random3

    #类型／品牌／价格
    @category_groups = CategoryGroup.published
    @brands = Brand.published
    @currentcies = Currency.all
  end

  #设定价格
  def setup_currency
    setup_currency

    redirect_to :back
  end

  #加入购物车
  def add_to_cart
    @product = Product.find(params[:id])
    @quantity = params[:quantity]

    if !current_cart.products.include?(@product)
       current_cart.add_product_to_cart(@product)
       flash[:notice] = "你已成功将 #{@product.title} 加入购物车"
    else
       flash[:warning] = "你的购物车内已有此物品"
    end
    redirect_to :back
 end
end
