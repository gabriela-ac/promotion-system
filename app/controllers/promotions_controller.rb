class PromotionsController < ApplicationController
  before_action :authenticate_user!, only: %i[index show]
  before_action :set_promotion, only: %i[show generate_coupons]

  def index
    @promotions = Promotion.all
  end

  def show; end

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
    @promotion.generate_coupons!
    flash[:success] = 'Cupons gerados com sucesso'
    redirect_to @promotion
  end

  private

  def promotion_params
    params
      .require(:promotion)
      .permit(:name, :description, :code, :discount_rate, :expiration_date, :coupon_quantity)
  end

  def set_promotion
    @promotion = Promotion.find(params[:id])
  end
end