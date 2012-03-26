require 'spec_helper'

describe Bookmark do

  before (:each) do
    @user     = Factory.create(:user)
    $user     = @user
    @bookmark = Factory.create(:bookmark, :url => "http://#{Faker::Internet.domain_name}")
  end

  it "grabs the domain from the url" do
    @bookmark.domain.should_not be_nil
  end

  it "validates a valid url" do
    Factory.build( :bookmark, :url => 'not valid').should_not be_valid
  end

  it "searched title correctly" do
    Factory.create( :bookmark, :title => 'foobar' )
    Bookmark.search( 'foobar').count.should == 1
  end

  it "searched notes correctly" do
    Factory.create( :bookmark, :notes => 'foobar' )
    Bookmark.search( 'foobar').count.should == 1
  end

  it "searched url correctly" do
    Factory.create( :bookmark, :url => 'http://www.foobar.com' )
    Bookmark.search( 'foobar').count.should == 1
  end

  it "finds a bookmark by tag" do
    tag = Factory.create(:tag, :name => 'foobar')
    Factory.create(:bookmarks_tag, :bookmark_id => @bookmark.id, :tag_id => tag.id)
    Bookmark.search( 'foobar').count.should == 1
  end


  it "url is unique for each user" do
    Factory.create( :bookmark )
    user = Factory.create( :user, :email => Faker::Internet.email )
    Factory.build( :bookmark, :user_id => user.id ).should be_valid
  end

  it "has many tags" do
    tag = Factory.create(:tag)
    Factory.create(:bookmarks_tag, :bookmark_id => @bookmark.id, :tag_id => tag.id)
    @bookmark.tags.length.should == 1
  end

end