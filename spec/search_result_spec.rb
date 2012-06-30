require "nzbmatrix/search_result"

module Nzbmatrix
  describe SearchResult do

    it "maps an api response nicely" do
      response = {
        "NZBID" => "396552",
        "NZBNAME" => "Dark Angel S01 WS AC3 DVDRip XviD SFM",
        "LINK" => "nzbmatrix.com/nzb-details.php?id=396552&hit=1",
        "SIZE" => "9628517662.72",
        "INDEX_DATE" => "2009-02-06 21:09:44",
        "USENET_DATE" => "2009-02-06 1:55:56",
        "CATEGORY" => "TV > SD",
        "GROUP" => "alt.binaries.multimedia",
        "COMMENTS" => "1",
        "HITS" => "849",
        "NFO" => "yes",
        "WEBLINK" => "http://former.imdb.com/title/tt0204993/",
        "LANGUAGE" => "English",
        "IMAGE" => "http://img132.imageshack.us/img132/3606/mv5bmtmxnja2mzk3nl5bml5kj5.jpg",
        "REGION" => "0",
      }

      result = SearchResult.new(response, nil)
      result.id.should eq(396552)
      result.name.should eq("Dark Angel S01 WS AC3 DVDRip XviD SFM")
      result.link.should eq("nzbmatrix.com/nzb-details.php?id=396552&hit=1")
      result.size.should eq(9628517662.72)
      result.index_date.should eq(Time.parse("2009-02-06 21:09:44"))
      result.usenet_date.should eq(Time.parse("2009-02-06 01:55:56"))
      result.category.should eq("TV > SD")
      result.group.should eq("alt.binaries.multimedia")
      result.comments.should eq(1)
      result.hits.should eq(849)
      result.has_nfo?.should be_true
      result.weblink.should eq("http://former.imdb.com/title/tt0204993/")
      result.language.should eq("English")
      result.has_image?.should be_true
      result.image_url.should eq("http://img132.imageshack.us/img132/3606/mv5bmtmxnja2mzk3nl5bml5kj5.jpg")
      result.region.should eq(0)
    end

    describe "#download" do
      let(:name) { "Asd asd" }
      let(:id) { 1234567 }
      let(:contents) { "asdasd" }
      let(:client_stub) do
        client_stub = double("client")
        client_stub.should_receive(:download).with(id).and_return(contents)

        client_stub
      end
      let(:result) do
        result = SearchResult.new({}, client_stub)
        result.id = id
        result.name = name

        result
      end
      
      it "allows you to download the nzb" do
        result.download.should == id

        File.file?("#{name}.nzb").should be_true
        File.read("#{name}.nzb").should == contents

        # clean up
        File.unlink("#{name}.nzb")
      end

      it "allows you to specify a path to download the file to" do
        result.download("/tmp").should == id

        File.file?("/tmp/#{name}.nzb").should be_true
        File.read("/tmp/#{name}.nzb").should == contents

        # clean up
        File.unlink("/tmp/#{name}.nzb")
      end
    end
  end
end
