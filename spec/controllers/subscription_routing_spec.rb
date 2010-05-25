# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'spec_helper'

describe SubscriptionsController do

  it "should map /users/1/subscriptions to SubscriptionsController with new action" do
    route_for(:controller => 'subscriptions', :action => 'new', :user_id => '1').should == {:method => :get, :path => '/users/1/subscriptions/new'}

    params_from(:get, '/users/1/subscriptions/new').should == {:controller => 'subscriptions', :action => 'new', :user_id => '1'}
  end

  it "should map 1 identified subscription from user 1 to its url home" do
    route_for(:action => 'show', :controller => 'subscriptions', :user_id => '1', :id => '1').should == '/users/1/subscriptions/1'

    params_from(:get, '/users/1/subscriptions/1').should == {:controller => 'subscriptions', :action => 'show', :user_id => '1', :id => '1'}
  end

  it "should map /users/1/subscriptions/1/edit to SubscriptionsController with edit action" do
    route_for(:controller => 'subscriptions', :action => 'edit', :user_id => '1', :id => '1').should == {:method => :get , :path => '/users/1/subscriptions/1/edit'}

    params_from(:get, '/users/1/subscriptions/1/edit').should == {:controller => 'subscriptions', :action => 'edit', :user_id => '1', :id => '1'}
  end

  it "should map /users/1/subscriptions with method POST to SubscriptionsController with create action" do
    route_for(:controller => 'subscriptions', :action => 'create', :user_id => '1').should == {:method => :post , :path => '/users/1/subscriptions'}

    params_from(:post, '/users/1/subscriptions').should == {:controller => 'subscriptions', :action => 'create', :user_id => '1'}
  end

end

