require 'rails_helper'

feature "records" do

  describe "index" do

    context "with no records added" do
      it "should allow you to add a record" do
        visit records_path
        expect(page).to have_content "no records added"
        expect(page).to have_link "add a record"
      end
    end

    context "with records added" do
      let!(:artist) {create(:artist)}
      let!(:record) {create(:record)}

      it "displays the record in index" do
        visit records_path
        expect(page).to have_content record.name
        expect(page).to have_content artist.name
        expect(page).not_to have_content "no records added"
      end

      it "links to show" do
        visit records_path
        click_link record.name
        expect(current_path).to eq(record_path(record))
      end
    end

    it "links to new" do
      visit records_path
      click_link "add a record"
      expect(current_path).to eq(new_record_path)
    end
  end

  describe "new" do
    context "with no artists added" do
      it "links through to add an artist" do
        visit new_record_path
        expect(page).to have_link "add artist"
      end
    end

    context "with artists added" do
    let!(:artist) {create(:artist)}
      it "shows artist" do
        visit new_record_path
        expect(page).to have_content(artist.name)
      end

      it "allows users to enter a record" do
        visit new_record_path
        expect{fill_in "Title", with: "After The Goldrush"
        select artist.name, from: "record[artist_id]"
        click_button "Add Record"
        }.to change{Record.count}.by 1
      end

      it "allows users to enter a record" do
        visit new_record_path
        fill_in "Title", with: "After The Goldrush"
        select artist.name, from: "record[artist_id]"
        click_button "Add Record"
        expect(current_path).to eq(new_record_track_path(Record.last.id))
      end

      it "can have an image uploaded" do
        visit new_record_path
        attach_file('record[avatar]', File.join(Rails.root, '/spec/fixtures/avatar.jpeg'))
        select artist.name, from: "record[artist_id]"
        click_button "Add Record"
        expect(Record.last.avatar).to be_a(AvatarUploader)
      end
    end
  end

  describe "show" do
    let!(:artist) {create(:artist)}
    let!(:record) {create(:record)}
    it "links to edit" do
      visit record_path(record)
      click_link "edit"
      expect(current_path).to eq(edit_record_path(record))
    end

    it "displays artist name" do
      visit record_path(record)
      expect(page).to have_content(artist.name)
    end

    context 'deleting' do
    let!(:artist) {create(:artist)}
    let!(:record) {create(:record)}
      it 'removes a record when a user clicks a delete link' do
        visit record_path(record)
        click_button "Delete Marquee Moon"
        expect(page).not_to have_content "Marquee Moon"
        expect(current_path).to eq(records_path)
        expect(page).to have_content 'Record deleted successfully'
      end
    end
  end

  describe "edit" do
    let!(:artist) {create(:artist)}
    let!(:record) {create(:record)}
    it "changes the record name" do
      visit edit_record_path(record)
      fill_in "Name", with: "Marquee Moon: 30th Anniversary edition"
      click_button 'Update Record'
      expect(page).to have_content "Marquee Moon: 30th Anniversary edition"
      expect(current_path).to eq record_path(record)
    end
  end

end