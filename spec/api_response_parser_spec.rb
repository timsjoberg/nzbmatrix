require "nzbmatrix/api_response_parser"

module Nzbmatrix
  describe ApiResponseParser do

    let(:parser) { ApiResponseParser.new }
    
    it "parses their format into an array of hashes" do
      response = <<EOF
NZBID:828303;
NZBNAME:Dark Angel S01 WS AC3 DVDRip XviD SFM;
LINK:nzbmatrix.com/nzb-details.php?id=828303&hit=1;
SIZE:9645389250.56;
INDEX_DATE:2011-01-24 23:22:02;
USENET_DATE:2011-01-24 11:11:31;
CATEGORY:TV > SD;
GROUP:alt.binaries.multimedia;
COMMENTS:0;
HITS:0;
NFO:yes;
WEBLINK:;
LANGUAGE:English;
IMAGE:;
REGION:0;
|
NZBID:734263;
NZBNAME:Dark Angel S01;
LINK:nzbmatrix.com/nzb-details.php?id=734263&hit=1;
SIZE:8328367308.8;
INDEX_DATE:2010-09-17 10:38:48;
USENET_DATE:2010-09-15 11:35:11;
CATEGORY:TV > SD;
GROUP:alt.binaries.x;
COMMENTS:0;
HITS:0;
NFO:;
WEBLINK:;
LANGUAGE:English;
IMAGE:http://img265.imageshack.us/img265/8043/darkangelshow.jpg;
REGION:0;
|
NZBID:396552;
NZBNAME:Dark Angel S01 WS AC3 DVDRip XviD SFM;
LINK:nzbmatrix.com/nzb-details.php?id=396552&hit=1;
SIZE:9628517662.72;
INDEX_DATE:2009-02-06 21:09:44;
USENET_DATE:2009-02-06 1:55:56;
CATEGORY:TV > SD;
GROUP:alt.binaries.multimedia;
COMMENTS:1;
HITS:849;
NFO:yes;
WEBLINK:http://former.imdb.com/title/tt0204993/;
LANGUAGE:English;
IMAGE:http://img132.imageshack.us/img132/3606/mv5bmtmxnja2mzk3nl5bml5kj5.jpg;
REGION:0;
|
EOF
      
      one = {
        "NZBID" => "828303",
        "NZBNAME" => "Dark Angel S01 WS AC3 DVDRip XviD SFM",
        "LINK" => "nzbmatrix.com/nzb-details.php?id=828303&hit=1",
        "SIZE" => "9645389250.56",
        "INDEX_DATE" => "2011-01-24 23:22:02",
        "USENET_DATE" => "2011-01-24 11:11:31",
        "CATEGORY" => "TV > SD",
        "GROUP" => "alt.binaries.multimedia",
        "COMMENTS" => "0",
        "HITS" => "0",
        "NFO" => "yes",
        "WEBLINK" => "",
        "LANGUAGE" => "English",
        "IMAGE" => "",
        "REGION" => "0",
      }

      two = {
        "NZBID" => "734263",
        "NZBNAME" => "Dark Angel S01",
        "LINK" => "nzbmatrix.com/nzb-details.php?id=734263&hit=1",
        "SIZE" => "8328367308.8",
        "INDEX_DATE" => "2010-09-17 10:38:48",
        "USENET_DATE" => "2010-09-15 11:35:11",
        "CATEGORY" => "TV > SD",
        "GROUP" => "alt.binaries.x",
        "COMMENTS" => "0",
        "HITS" => "0",
        "NFO" => "",
        "WEBLINK" => "",
        "LANGUAGE" => "English",
        "IMAGE" => "http://img265.imageshack.us/img265/8043/darkangelshow.jpg",
        "REGION" => "0",
      }

      three = {
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
      
      expected = [one, two, three]
      parser.parse(response).should eq(expected)
    end
  end
end
