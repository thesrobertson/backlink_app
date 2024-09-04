require "application_system_test_case"

class BacklinksTest < ApplicationSystemTestCase
  setup do
    @backlink = backlinks(:one)
  end

  test "visiting the index" do
    visit backlinks_url
    assert_selector "h1", text: "Backlinks"
  end

  test "should create backlink" do
    visit backlinks_url
    click_on "New backlink"

    click_on "Create Backlink"

    assert_text "Backlink was successfully created"
    click_on "Back"
  end

  test "should update Backlink" do
    visit backlink_url(@backlink)
    click_on "Edit this backlink", match: :first

    click_on "Update Backlink"

    assert_text "Backlink was successfully updated"
    click_on "Back"
  end

  test "should destroy Backlink" do
    visit backlink_url(@backlink)
    click_on "Destroy this backlink", match: :first

    assert_text "Backlink was successfully destroyed"
  end
end
