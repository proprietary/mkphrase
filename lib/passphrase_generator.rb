#!/usr/bin/env ruby

require 'securerandom'
require 'optparse'
require 'ostruct'

require_relative './wordlist'

def generate(wordlist, n_words)
  randomness = SecureRandom.random_bytes(8 * n_words).unpack("J*")
  wordlist_length = wordlist.length
  passphrase = Array.new
  randomness.each do |r|
    passphrase << wordlist[r % wordlist_length]
  end
  passphrase.join ' '
end

options = OpenStruct.new
OptionParser.new do |option|
  option.on('-w',
            '--wordlist [WORDLIST_FILE_PATH]',
            'A file of words with one word per line') do |o|
    options.wordlist_path = o
  end
  option.on('-n',
            '--num NUM_WORDS',
            Integer,
            'How long you want your passphrase to be') do |o|
    options.num_words = o
  end
  options.wordlist_path ||= File.absolute_path('wordlists/english.txt')
end.parse!

WORDLIST = Wordlist.new options.wordlist_path
puts generate(WORDLIST, options.num_words)
