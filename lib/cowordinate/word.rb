require 'httparty'
require 'json'

module Cowordinate

	class << self
		def Word(name)
			Cowordinate::Word.search(name)
		end
	end

	class Word
	  
	  attr_accessor :name, :parts, :updated_at

		def self.search(name)
			raw_json = HTTParty.get("http://cowordinate.com/words/#{name}.json")
			attrs = JSON.parse(raw_json.body)
			Cowordinate::Word.new(attrs["word"])
		rescue
		  nil
		end
		
		def initialize(options)
		  self.name = options["name"]
		  self.parts = options["parts"]
		  self.updated_at = options["updated_at"]
		end
		
		['adjective', 'adverb', 'preposition', 'pronoun', 'noun', 'verb'].each do |pos|
		  define_method "#{pos}?" do
		    parts.split(",").include?(pos.to_s)
	    end
	  end

	end

end

