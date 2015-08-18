require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('spec_helper')

describe('the path of lists', {:type => :feature}) do
  it('what it does') do
    visit('/')
    expect(page).to have_content('All the stuff you have to do.')
  end

  it('fills out form and list is added to frontpage') do
    visit('/')
    fill_in('name', :with => "Honey Dew")
    click_button('Add List')
    expect(page).to have_content("Honey Dew")
  end
end
