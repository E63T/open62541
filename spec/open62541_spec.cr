require "./spec_helper"

describe Open62541 do
  # TODO: Write tests

  it "works" do
    ua_client = LibOpen62541.ua_client_new
    ua_client.null?.should eq(false)
  end
end
