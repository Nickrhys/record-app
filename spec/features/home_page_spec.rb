require 'rails_helper'

feature "home" do

  it "work" do
    visit root_path
    expect(page).to have_content("Record Catalogue")
  end

  it "should have link to add record page" do
    visit root_path
    click_link "add a record"
    expect(current_path).to eq(new_record_path)
  end

  it "should have link to view records page" do
    visit root_path
    click_link "view all records"
    expect(current_path).to eq(records_path)
  end

end
