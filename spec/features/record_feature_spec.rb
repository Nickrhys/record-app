require 'rails_helper'

feature 'records' do
  context 'with no records added' do
    it "should allow you to add a record" do
      visit records_path
      expect(page).to have_content "no records added"
      expect(page).to have_link "add a record"
    end
  end
end