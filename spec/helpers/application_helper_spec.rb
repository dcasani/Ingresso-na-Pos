require 'spec_helper'

describe ApplicationHelper do

  it "should be included in the object returned by #helper" do
    pending
    include ApplicationHelper
    included_modules = (class << helper; self; end).send :included_modules
    #included_modules.should include(ApplicationHelper)
    included_modules.flash_helper
  end

  #Delete this example and add some real ones or delete this file
  it "should be included in the object returned by #helper" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(ApplicationHelper)
  end

end
