# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'spec_helper'

describe UsersController do

  it "should map /users/new to UsersController with new action" do
    route_for(:controller => 'users', :action => 'new').should == {:method => :get, :path => '/users/new'}

    params_from(:get, '/users/new').should == {:controller => 'users', :action => 'new'}
  end

  it "should map 1 identified user to its url home" do
    route_for(:action => 'show', :controller => 'users', :id => '1').should == '/users/1'

    params_from(:get, '/users/1').should == {:controller => 'users', :action => 'show', :id => '1'}
  end

  it "should map /user/1/edit to UsersController with edit action" do
    route_for(:action => 'edit', :controller => 'users', :id => '1').should == '/users/1/edit'

    params_from(:get, '/users/1/edit').should == {:controller => 'users', :action => 'edit', :id => '1'}
  end

  it "should map /users with method POST to UsersController with create action" do
    route_for(:controller => 'users', :action => 'create').should == {:method => :post , :path => '/users'}

    params_from(:post, '/users').should == {:controller => 'users', :action => 'create'}
  end

end

