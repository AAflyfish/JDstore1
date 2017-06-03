class Account::OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.recent.paginate(:page => params[:page], :per_page => 5)  # 增加大于5分页
  end

end
