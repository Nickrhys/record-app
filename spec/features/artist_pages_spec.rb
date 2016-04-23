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

  describe "index" do
    context "with artists added" do
      let!(:artist) {FactoryGirl.create(:artist)}

      it "displays the artist in index" do
        visit artists_path
        expect(page).to have_content artist.name
      end

      context "with records" do
        let!(:record) {FactoryGirl.create(:record)}
        
        it "links through to records" do
          visit artists_path
          click_link artist.name
          expect(current_path).to eq "/artists/#{artist.id}/records"
          expect(page).to have_content record.name
        end
      end
    end  
  end

end