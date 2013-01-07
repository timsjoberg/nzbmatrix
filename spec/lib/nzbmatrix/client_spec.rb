require "spec_helper"

module Nzbmatrix
  describe Client do

    let(:c) { Client.new(:user_id, :api_key) }

    it "adds the api_key when making requests to /api" do
      c.should_receive(:get).with("http://nzb-matrix.eu/api", {
                                    params: { t: "function", apikey: :api_key, foo: "bar" }
                                  })
      c.api_request("function", :foo => "bar")
    end

    
  end
end
