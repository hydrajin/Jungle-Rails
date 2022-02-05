class Admin::DashboardController < ApplicationController
  def show
    @count_product=Product.count
    @count_category=Category.count
  end
end
