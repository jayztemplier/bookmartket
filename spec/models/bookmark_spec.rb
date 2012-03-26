require 'spec_helper'

describe Bookmark do

  before (:each) do
    @bookmark = Factory.create(:bookmark)
    @user     = Factory.create(:user)
  end

  it "grabs the domain from the url" do
    @bookmark.domain.should_not be_nil
  end

  it "validates a valid url" do
    Factory.build( :bookmark, :url => 'not valid', :user_id => @user.id ).should_not be_valid
  end

  it "searched correctly" do
    3.times do
      Factory.create( :bookmark, :url => 'https://'+Faker::Internet.domain_name, :title => 'foobar', :user_id => @user.id )
    end
    Bookmark.search( @user.api_key, 'foobar').count.should == 3
  end

  it "url is unique for each user" do
    Factory.create( :bookmark, :user_id => @user.id )
    user = Factory.create( :user, :email => Faker::Internet.email )
    Factory.build( :bookmark, :user_id => user.id ).should be_valid
  end

end