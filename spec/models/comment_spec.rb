require 'spec_helper'

describe Comment do
  
  context "adding a comment" do

    context "success" do

        it "should be created when we provide some text, name and an associated article" do
          @article = Article.create(title: "my title", body: "some body")
          @comment = Comment.new(name: "my name", body: "this is my comment", article: @article)

          expect(@comment).to be_valid
        end
    end

    context "failure" do

        it "shouldn't be created without a body" do
          @article = Article.create(title: "my title", body: "some body")
          @comment = Comment.new(article: @article)

          expect(@comment).not_to be_valid
        end

        it "shouldn't be created without an article" do
          @comment = Comment.new(body: "this is my comment")
          expect(@comment).not_to be_valid
        end

        it "shouldn't be created without a valid article" do
          @article = Article.new(title: "my title")
          @comment = Comment.new(body: "this is my comment", article: @article)
          expect(@comment).not_to be_valid
        end

        it "shouldn't be created without a user" do
          @article = Article.create(title: "my title", body: "some body")
          @comment = Comment.new(body: "this is my comment", article: @article)

          expect(@comment).not_to be_valid
        end
    end

  end

end
