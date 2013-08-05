require 'spec_helper'

describe Article do

  context "creating an article" do


    context "success" do

        it "should be created when we provide a title and body" do
            @article = Article.new(title: "my title", body: "some body")
            expect(@article).to be_valid
        end

    end

    context "failure" do 

        it "should not be created if we only provide a title and not a body" do
          @article = Article.new(title: "sdsd")
          expect(@article).not_to be_valid
        end

        it "should not be created if we only provide a body and no title" do
          @article = Article.new(body: "some body text")
          expect(@article).not_to be_valid
        end
        
    end

  end
  



end