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

  it('it displays tasks in a list') do
    List.new({:name => "Honey Dew"}).save()
    visit('/')
    click_link("Honey Dew")
    expect(page).to have_content("All the little things...")
  end

  it('fills out add task form and it is added to list page') do
    List.new({:name => "Honey Dew"}).save()
    visit('/')
    click_link("Honey Dew")
    fill_in('description', :with => "Buy Milk")
    click_button('Add Task')
    expect(page).to have_content("Buy Milk")
  end
end
