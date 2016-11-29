require 'rails_helper'

feature "tracks" do

  describe "new" do

    describe "new" do
      let!(:artist) {create(:artist)}

      it "creates tracks", js: true do
        record = Record.create!(artist_id: artist.id)
        visit new_record_track_path(record.id)
        fill_in "track[name]", with: "Tell Me Why"
        click_on "Create Track"
        expect(page).to have_content("Tell Me Why")
      end
    end
  end

end
