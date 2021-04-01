class CouponsController < ApplicationController
  def inactivate
    @coupon = Coupon.find(params[:id])
    flash[:success] = 'Cupom cancelado com sucesso'
    redirect_to @coupon.promotion
  end
end