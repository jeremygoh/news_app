require 'spec_helper'




describe "seeing an article on the articles page" do

  xit "should display a newly created article on the articles page" do
    create_article("my title", "some body text")
    visit '/articles'
    expect(page).to have_css "h2", text: "my title"
    expect(page).to have_content "some body text"
  end
end

describe "adding an article" do

  it "should allow an ad to be created if the title and body are filled in and redirect to articles" do
    visit '/articles/new'
    fill_in "article[title]", with: "My First Article"
    fill_in "article[body]", with: "the body goes here"
    click_on "Submit"
    expect(Article.count).to eq 1
    expect(page).to have_content "My First Article"
  end

  it "should redirect to create article form if the title is missing" do
    visit '/articles/new'
    fill_in "article[body]", with: "the body goes here"
    click_on "Submit"
    expect(current_path).to eq "/articles/new"
  end

end

describe "accessing an article" do

  it "should allow access to an article once it has been created" do
    quick_create
    expect(Article.count).to eq 1
    visit "/articles/#{Article.last.id}"
    expect(page).to have_css "h2", text: "My Article"
    expect(page).to have_content "the body text"
  end

end

describe "editing an article" do

  it "should allow an article to be edited" do
    quick_create
    visit "/articles/#{Article.last.id}/edit"
    expect(Article.count).to eq 1
    fill_in "article[title]", with: "new title"
    fill_in "article[body]", with: "new body"
    click_on "Submit"
    visit "/articles/#{Article.last.id}"
    expect(page).to have_content "new title"
    expect(page).to have_content "new body"
    expect(Article.count).to eq 1
  end

  it "shouldn't allow an edit if the form is not completely filled in" do
    quick_create
    visit "/articles/#{Article.last.id}/edit"
    expect(Article.count).to eq 1
    fill_in "article[body]", with: "new body"
    click_on "Submit"
    visit "/articles/#{Article.last.id}"
    expect(page).not_to have_content "new title"
  end
end

describe "deleting an article" do

  it "should allow deletion of an article on edit page" do
    quick_create
    visit "/articles/#{Article.last.id}/edit"
    click_on "Delete"
    expect(Article.count).to eq 0
  end
end
