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
      let!(:artist) {FactoryGirl.create(:artist)}
      let!(:record) {FactoryGirl.create(:record)}

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
    let!(:artist) {FactoryGirl.create(:artist)}
      it "shows artist" do
        visit new_record_path
        expect(page).to have_content(artist.name)
      end

      it "allows users to enter a record" do
        visit new_record_path
        expect{fill_in "Title", with: "After The Goldrush"
        fill_in "Track 1", with: "Only love can break your heart"
        select artist.name, from: "record[artist_id]"
        click_button "Add Record"
        expect(current_path).to eq records_path
        }.to change{Record.count}.by 1
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
    let!(:artist) {FactoryGirl.create(:artist)}
    let!(:record) {FactoryGirl.create(:record)}
    let!(:track) {FactoryGirl.create(:track)}
    it "links to edit" do
      visit record_path(record)
      click_link "edit"
      expect(current_path).to eq(edit_record_path(record))
    end

    it "displays artist name" do 
      visit record_path(record)
      expect(page).to have_content(artist.name)
    end

    it "displays track names" do
      another_track = Track.create(name: "Friction", record_id: record.id)
      visit record_path(record)
      expect(page).to have_content(track.name)
      expect(page).to have_content(another_track.name)
    end

    context 'deleting' do
    let!(:artist) {FactoryGirl.create(:artist)}
    let!(:record) {FactoryGirl.create(:record)}
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
    let!(:artist) {FactoryGirl.create(:artist)}
    let!(:record) {FactoryGirl.create(:record)}
    it "changes the record name" do
      visit edit_record_path(record)
      fill_in "Name", with: "Marquee Moon: 30th Anniversary edition"
      click_button 'Update Record'
      expect(page).to have_content "Marquee Moon: 30th Anniversary edition"
      expect(current_path).to eq record_path(record)
    end
  end

end