class Wordlist
  attr_accessor :words
  
  def initialize(filename)
       @words = IO.readlines(filename, :chomp => true)
  end

  def length
    @words.length
  end

  def [](idx)
    @words[idx]
  end
end
