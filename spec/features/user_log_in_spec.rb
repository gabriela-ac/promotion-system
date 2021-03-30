require 'rails_helper'

feature 'User log in' do
  scenario 'and receive welcome message' do
    User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')

    visit root_path
    click_on 'Login'
    fill_in 'Email', with: 'jane_doe@locaweb.com.br'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'

    expect(current_path).to eq(root_path)
    expect(page).to have_content ('Login efetuado com sucesso')
    expect(page).to have_content('jane_doe@locaweb.com.br')
    expect(page).not_to have_link('Login')
    expect(page).to have_link('Sair')
  end

  xscenario 'and log out' do
    User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')

    visit root_path
    click_on 'Login'
    fill_in 'Email', with: 'jane_doe@locaweb.com.br'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'

    expect(current_path).to eq(root_path)
    # expect(page).to have_content ('Login efetuado com sucesso')
    expect(page).not_to have_content('jane_doe@locaweb.com.br')
    expect(page).to have_link('Login')
    expect(page).not_to have_link('Sair')
  end
end