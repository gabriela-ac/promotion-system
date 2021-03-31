class PromotionsController < ApplicationController
  before_action :authenticate_user!, only: %i[index show]

  def index
    @promotions = Promotion.all
  end

  def show
    @promotion = Promotion.find(params[:id])
  end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(promotion_params)
    if @promotion.save
      redirect_to @promotion
    else
      render :new
    end
  end

  def generate_coupons
    @promotion = Promotion.find(params[:id])
    (1..@promotion.coupon_quantity).each do |number|
      code = "#{@promotion.code}-#{'%04d' % number}"
      Coupon.create!(promotion: @promotion, code: code)
    end
    flash[:success] = 'Cupons gerados com sucesso'

    redirect_to @promotion
  end

  private

  def promotion_params
    params
      .require(:promotion)
      .permit(:name, :description, :code, :discount_rate, :expiration_date, :coupon_quantity)
  end
end