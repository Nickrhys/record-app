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

      it "displays the record in index" do
        Record.create(name: "Marquee Moon")
        visit records_path
        expect(page).to have_content "Marquee Moon"
        expect(page).not_to have_content "no records added"
      end

      it "links to show" do
        record = Record.create(name: "Marquee Moon")
        visit records_path
        click_link "Marquee Moon"
        puts "#{record}"
        expect(page).to have_content("Marquee Moon")
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
    context "create a record" do
      it "allows users to enter a record" do
        visit new_record_path
        fill_in "Name", with: "After The Goldrush"
        click_button "Create Record"
        expect(page).to have_content "After The Goldrush"
        expect(current_path).to eq records_path
      end
    end

    context "with no artists added" do
      it "links through to add an artist" do 
        visit new_record_path
        expect(page).to have_link "add artist"
      end
    end

    context "with artists added" do
      it "shows artist" do
        artist = Artist.create(name: "Television")
        visit new_record_path
        expect(page).to have_content("Television")
      end
    end  
  end

  describe "show" do
    it "links to edit" do
      record = Record.create(name: "Marquee Moon")
      visit record_path(record)
      click_link "edit"
      expect(current_path).to eq(edit_record_path(record))
    end

    context 'deleting' do
      it 'removes a record when a user clicks a delete link' do
        record = Record.create(name: "Marquee Moon")
        visit record_path(record)
        click_button "Delete Marquee Moon"
        expect(page).not_to have_content "Marquee Moon"
        expect(current_path).to eq(records_path)
        expect(page).to have_content 'Record deleted successfully'
      end
    end
  end

  describe "edit" do
    it "changes the record name" do
      record = Record.create(name: "Marquee Moon")
      visit edit_record_path(record)
      fill_in "Name", with: "Marquee Moon: 30th Anniversary edition"
      click_button 'Update Record'
      expect(page).to have_content "Marquee Moon: 30th Anniversary edition"
      expect(current_path).to eq record_path(record)
    end
  end

end