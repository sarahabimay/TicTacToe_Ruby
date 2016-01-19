require_relative "../lib/mark"
require "rspec"

class MarkTest
  describe Mark do
    it "contains two enums Mark::X" do
      expect(Mark::X).to eq("X")
    end 
    it "contains enums Mark::O" do
      expect(Mark::O).to eq("O")
    end 
    it "doesn't contain anything but Mark::X and Mark::O" do
      expect(Mark.is_a_mark?("BLAH")).to eq(false)
    end
  end
end
