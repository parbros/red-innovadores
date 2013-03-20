# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Ideas" do
    describe "Admin" do
      describe "ideas" do
        login_refinery_user

        describe "ideas list" do
          before do
            FactoryGirl.create(:idea, :title => "UniqueTitleOne")
            FactoryGirl.create(:idea, :title => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.ideas_admin_ideas_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.ideas_admin_ideas_path

            click_link "Add New Idea"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Title", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Ideas::Idea.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Title can't be blank")
              Refinery::Ideas::Idea.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:idea, :title => "UniqueTitle") }

            it "should fail" do
              visit refinery.ideas_admin_ideas_path

              click_link "Add New Idea"

              fill_in "Title", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Ideas::Idea.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:idea, :title => "A title") }

          it "should succeed" do
            visit refinery.ideas_admin_ideas_path

            within ".actions" do
              click_link "Edit this idea"
            end

            fill_in "Title", :with => "A different title"
            click_button "Save"

            page.should have_content("'A different title' was successfully updated.")
            page.should have_no_content("A title")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:idea, :title => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.ideas_admin_ideas_path

            click_link "Remove this idea forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Ideas::Idea.count.should == 0
          end
        end

      end
    end
  end
end
