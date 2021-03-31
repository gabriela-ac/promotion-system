class Promotion < ApplicationRecord
  has_many :coupons, dependent: :destroy

  validates :name, :code, :discount_rate,
                   :coupon_quantity, :expiration_date,
                   presence: true
  validates :code, uniqueness: true

  def generate_coupons!
    codes = (1..coupon_quantity).map do |number|
      { code: "#{code}-#{'%04d' % number}" }
    end
    coupons.create!(codes)
  end
end


# def generate_coupons!
#   (1..coupon_quantity).each do |number|
#     coupons.create!(code: "#{code}-#{'%04d' % number}")
#   end
# end
