require 'spec_helper'

describe UsersController do

  context "deve validar o controlador" do

    it { UsersController.new.should be_an_instance_of(UsersController) }

  end

  context 'should validates the routes' do
	    it 'should generate a route by GET from /users to { :controller=>"users", :action=>"index" }' do
	      params_from(:get, users_path).should eql({ :controller=>'users', :action=>'index' })
      end
  end
end