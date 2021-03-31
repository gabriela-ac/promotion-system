class Promotion < ApplicationRecord
  has_many :coupons, dependent: :destroy

  validates :name, :code, :discount_rate,
                   :coupon_quantity, :expiration_date,
                   presence: true
  validates :code, uniqueness: true
  validates :coupon_quantity, numericality: { greater_than: 0 }

  def generate_coupons!
    raise 'Cupons já foram gerados' if coupons.any?

    coupons.create!(generate_coupons_codes)
  end
end

private

def generate_coupons_codes
  codes = (1..coupon_quantity).map do |number|
    { code: "#{code}-#{'%04d' % number}" }
  end
end


# def generate_coupons!
#   (1..coupon_quantity).each do |number|
#     coupons.create!(code: "#{code}-#{'%04d' % number}")
#   end
# end
