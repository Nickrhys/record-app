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

    context "create a record" do
      it "allows users to enter a record" do
        visit records_path
        click_link "add a record"
        fill_in "Name", with: "After The Goldrush"
        click_button "Create Record"
        expect(page).to have_content "After The Goldrush"
        expect(current_path).to eq records_path
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

    describe "edit" do
      it "changes the record name" do
        record = Record.create(name: "Marquee Moon")
        visit record_path(record)
        click_link "edit"
        fill_in "Name", with: "Marquee Moon: 30th Anniversary edition"
        click_button 'Update Record'
        expect(page).to have_content "Marquee Moon: 30th Anniversary edition"
        expect(current_path).to eq record_path(record)
      end
    end
  end

end