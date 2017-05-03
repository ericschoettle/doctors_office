require('capybara/rspec')
require('./app')
require('pry')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('doctors office', {:type => :feature}) do
  it "adds a specialty, adds a doctor to that specialty, adds a patient to that doctor, and clicks on that doctor to see the patient" do
    visit('/')
    within('#specialty') {fill_in("name", :with => "urology")}
    click_button("Add the specialty")
    expect(page).to have_content('urology')
    within('#doctor') {fill_in("name", :with => "danger")}
    find('#specialtySelect').find(:xpath, 'option[1]').select_option
    click_button("Add the doctor")
    expect(page).to have_content('danger')
    click_link("urology")
  end
end
