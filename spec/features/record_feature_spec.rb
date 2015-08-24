require 'rails_helper'

feature "records" do
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
  end
end