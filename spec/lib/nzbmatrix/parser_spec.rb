require "spec_helper"

module Nzbmatrix
  describe Parser do

    let(:p) { Parser.new }
    let(:xml) { File.read(File.expand_path("data/search.xml", SPEC_ROOT)) }
    let(:doc) { Nokogiri::XML(xml) }

    it "determines the item class based off the first category id" do
      expect(p.item_class(doc.xpath("//item").first)).to eq(TvItem)
    end

    it "maps //item into an array of item objects" do
      items = p.call(xml)
      expect(items).to be_a(Array)
      expect(items.size).to eq(2)
      expect(items.all? {|i| i.kind_of?(Item)}).to be_true
    end
  end
end
