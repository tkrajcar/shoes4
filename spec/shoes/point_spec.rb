require 'shoes/spec_helper'

describe Shoes::Point do
  subject { Shoes::Point.new(40, 50) }
  let(:other_point) { Shoes::Point.new(10, 60) }

  its(:x) { should eq(40) }
  its(:y) { should eq(50) }

  it "#left works on either point" do
    expect(subject.left(other_point)).to eq(10)
    expect(other_point.left(subject)).to eq(10)
  end

  it "#top works on either point" do
    expect(subject.top(other_point)).to eq(50)
    expect(other_point.top(subject)).to eq(50)
  end

  describe "equality" do
    it "requires x and y to be equal" do
      expect(subject).to eq(Shoes::Point.new 40, 50)
      expect(subject).not_to eq(Shoes::Point.new 41, 50)
      expect(subject).not_to eq(Shoes::Point.new 40, 51)
    end

    it "works with other (x,y) objects" do
      expect(subject).to eq(Struct.new(:x, :y).new(40, 50))
    end
  end

  describe "#to" do
    it "positive" do
      expect(subject.to(24, 166)).to eq(Shoes::Point.new(64, 216))
    end

    it "negative" do
      expect(subject.to(-24, -166)).to eq(Shoes::Point.new(16, -116))
    end
  end

  it "calculates width of rectangle created with other point" do
    expect(subject.width(other_point)).to eq(30)
    expect(other_point.width(subject)).to eq(30)
  end

  it "calculates height of rectangle created with other point" do
    expect(subject.height(other_point)).to eq(10)
    expect(other_point.height(subject)).to eq(10)
  end

  describe "converting to string" do
    include InspectHelpers

    it "looks like (x,y)" do
      expect(subject.to_s).to eq("(40,50)")
    end

    it "inspects like (Shoes::Point:0x01234567 (x,y))" do
      expect(subject.inspect).to match(/[(]Shoes::Point:#{shoes_object_id_pattern} [(]40,50[)][)]/)
    end
  end
end
