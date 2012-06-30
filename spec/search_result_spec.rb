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
      it "allows you to download the nzb" do
        client_stub = double("client")
        client_stub.should_receive(:download).with(1234567).and_return("asdasd")
        
        result = SearchResult.new({}, client_stub)
        result.id = 1234567
        result.name = "Asd asd"

        result.download.should == 1234567

        File.file?("Asd asd.nzb").should be_true
        File.read("Asd asd.nzb").should == "asdasd"

        # clean up
        File.unlink("Asd asd.nzb")
      end

      it "allows you to specify a path to download the file to" do
        client_stub = double("client")
        client_stub.should_receive(:download).with(1234567).and_return("asdasd")
        
        result = SearchResult.new({}, client_stub)
        result.id = 1234567
        result.name = "Asd asd"

        result.download("/tmp").should == 1234567

        File.file?("/tmp/Asd asd.nzb").should be_true
        File.read("/tmp/Asd asd.nzb").should == "asdasd"

        # clean up
        File.unlink("/tmp/Asd asd.nzb")
      end
    end
  end
end
