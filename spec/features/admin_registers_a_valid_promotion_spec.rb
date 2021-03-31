require 'rails_helper'

feature 'Admin registers a valid promotion' do
  scenario 'and attributes cannot be blank' do
    user = User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')

    login_as user, scope: :user

    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'
    click_on 'Criar promoção'

    expect(page).to have_content('não pode ficar em branco', count: 5)
  end

  scenario 'and code must be unique' do
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')
    user = User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'
    fill_in 'Código', with: 'NATAL10'
    click_on 'Criar promoção'

    expect(page).to have_content('já está em uso')
  end
end

