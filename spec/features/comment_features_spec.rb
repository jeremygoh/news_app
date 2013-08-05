require 'spec_helper'

def comment_article_create
      quick_create()
      visit "/articles/#{Article.last.id}"
      fill_in "comment[name]", with: "Joe Bloggs"
      fill_in "comment[body]", with: "this is an interesting article"
      click_on "Submit"

end


describe "creating a comment" do

  it "should allow a comment to be created on an article page" do
      quick_create()
      visit "/articles/#{Article.last.id}"
      fill_in "comment[name]", with: "Joe Bloggs"
      fill_in "comment[body]", with: "this is an interesting article"
      click_on "Submit"
      expect(Article.last.comments.count).to eq 1
  end

  it "shouldn't allow a comment to be created if a name is not specified" do
      quick_create()
      visit "/articles/#{Article.last.id}"
      fill_in "comment[body]", with: "this is an interesting article"
      click_on "Submit"
      expect(Article.last.comments.count).not_to eq 1
  end

  it "shouldn't allow a comment to be created if a name is not specified" do
      quick_create()
      visit "/articles/#{Article.last.id}"
      fill_in "comment[name]", with: "Joe Bloggs"
      click_on "Submit"
      expect(Article.last.comments.count).not_to eq 1
  end


  it "should display the newly created comment on the article page" do
      quick_create()
      visit "/articles/#{Article.last.id}"
      fill_in "comment[name]", with: "Joe Bloggs"
      fill_in "comment[body]", with: "this is an interesting article"
      click_on "Submit"
      expect(page).to have_content "Joe Bloggs"
      expect(page).to have_content "this is an interesting article"
  end

  it "should allow viewing of an individual comment" do 
      quick_create()
      visit "/articles/#{Article.last.id}"
      fill_in "comment[name]", with: "Joe Bloggs"
      fill_in "comment[body]", with: "this is an interesting article"
      click_on "Submit"
      visit "/articles/#{Article.last.id}/comments/#{Article.last.comments.last.id}"
      expect(page).to have_content "Joe Bloggs"
      expect(page).to have_content "this is an interesting article"
  end
end


describe "view comments for an article" do
  it "should allow viewing of all the comments for a particular article" do
      quick_create()
      visit "/articles/#{Article.last.id}/comments"
      expect(page).to have_content "Joe Bloggs"
      expect(page).to have_content "this is an interesting article"
  end
end

describe "editing a comment" do

  it "should allow editing of a comment" do
      comment_article_create
      visit "/articles/#{Article.last.id}/comments/#{Article.last.comments.last.id}/edit"
      fill_in "comment[name]", with: "John Blogg"
      fill_in "comment[body]", with: "this is not an interesting article"
      click_on "Submit"
      expect(Article.last.comments.count).to eq 1
      visit "/articles/#{Article.last.id}"
      expect(page).to have_content "John Blogg"
  end
end

describe "deleting a comment" do

  it "should allow deleting of a comment" do
    comment_article_create
    visit "/articles/#{Article.last.id}/comments/#{Article.last.comments.last.id}/edit"
    click_on "Delete"
    expect(Article.last.comments.count).to eq 0
    expect(current_path).to eq "/articles/#{Article.last.id}"
  end
end
