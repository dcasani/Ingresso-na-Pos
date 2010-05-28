# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'spec_helper'

describe SubscriptionsController do

  it "should map SubscriptionsController::NEW to /user/1/subscriptions/new" do
    route_for(:controller => 'subscriptions', :action => 'new', :user_id => '1').should == {:method => :get, :path => '/users/1/subscriptions/new'}

    params_from(:get, '/users/1/subscriptions/new').should == {:controller => 'subscriptions', :action => 'new', :user_id => '1'}
  end

  it "should map SubscriptionsController::CREATE to /user/1/subscriptions" do
    route_for(:controller => 'subscriptions', :action => 'create', :user_id => '1').should == {:method => :post , :path => '/users/1/subscriptions'}

    params_from(:post, '/users/1/subscriptions').should == {:controller => 'subscriptions', :action => 'create', :user_id => '1'}
  end

  it "should map SubscriptionsController::DESTROY to /user/1/subscriptions/1" do
    route_for(:controller => 'subscriptions', :action => 'destroy', :user_id => '1', :id => '1').should == {:method => :delete , :path => '/users/1/subscriptions/1'}

    params_from(:delete, '/users/1/subscriptions/1').should == {:controller => 'subscriptions', :action => 'destroy', :user_id => '1', :id => '1'}
  end

  it "should map SubscriptionsController::UPDATE to /user/1/subscriptions/1" do
    route_for(:controller => 'subscriptions', :action => 'update', :user_id => '1', :id => '1').should == {:method => :put , :path => '/users/1/subscriptions/1'}

    params_from(:put, '/users/1/subscriptions/1').should == {:controller => 'subscriptions', :action => 'update', :user_id => '1', :id => '1'}
  end

  it "should map SubscriptionsController::SHOW to /user/1/subscriptions/1" do
    route_for(:controller => 'subscriptions', :action => 'show', :user_id => '1', :id => '1').should == '/users/1/subscriptions/1'

    params_from(:get, '/users/1/subscriptions/1').should == {:controller => 'subscriptions', :action => 'show', :user_id => '1', :id => '1'}
  end

  it "should map SubscriptionsController::EDIT to /user/1/subscriptions/1/edit" do
    route_for(:controller => 'subscriptions', :action => 'edit', :user_id => '1', :id => '1').should == {:method => :get , :path => '/users/1/subscriptions/1/edit'}

    params_from(:get, '/users/1/subscriptions/1/edit').should == {:controller => 'subscriptions', :action => 'edit', :user_id => '1', :id => '1'}
  end

  it "should map SubscriptionsController::INDEX to /user/1/subscriptions" do
    route_for(:controller => 'subscriptions', :action => 'index', :user_id => '1').should == {:method => :get , :path => '/users/1/subscriptions'}

    params_from(:get, '/users/1/subscriptions').should == {:controller => 'subscriptions', :action => 'index', :user_id => '1'}
  end
end

