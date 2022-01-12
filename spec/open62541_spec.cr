require "./spec_helper"

describe Open62541 do
  # TODO: Write tests

  it "works" do
    client = Open62541::Client.new "opc://localhost:1337"
    client.read_value_attribute(Open62541::NodeID.new(0, "foo")).as_i16.should eq(1i16)
  end
end
