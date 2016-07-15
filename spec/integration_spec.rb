require('spec_helper.rb')
require('capybara/rspec')
require('./app')
require('launchy')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe 'the stylist path', {:type => :feature} do
  it "gets to the Manage Stylists page" do
    visit '/'
    click_link "Manage Stylists"
    expect(page).to have_content("Manage Your Stylists")
  end

  it "allows the user to add a stylist" do
    visit '/stylists'
    click_link 'Add a New Stylist'
    fill_in('name', :with => 'Chris Zamora')
    fill_in('station', :with => '2')
    click_button('Add Stylist')
    expect(page).to have_content("Chris Zamora")
  end
end
