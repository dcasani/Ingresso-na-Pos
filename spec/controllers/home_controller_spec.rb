# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'spec_helper'

describe HomeController do

  context "GET index" do
    it "should show home page" do
      get :index
      response.should be_success
    end
  end
end
