class SectionData < Hash
  def self.load(string)
    new JSON.load string
  end

  def self.dump(sd)
    fail 'must be a SectionData' unless sd.is_a? SectionData
    JSON.dump sd
  end
end
