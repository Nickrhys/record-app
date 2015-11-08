require 'rails_helper'

feature 'artists' do 

  describe "new" do
    context "create a artist" do
      it "allows users to enter a record" do
        visit new_artist_path
        fill_in "Name", with: "Television"
        click_button "Create Artist"
        expect(current_path).to eq "/records/new"
        expect(page).to have_content "Television"
      end
    end
  end
end