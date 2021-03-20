
class Book
    
    attr_accessor :title, :authors, :published_date, :genre, :synopsis, :link, :users

    @@results = []

    def initialize(book)
        @title = book[:volumeInfo][:title]
        @authors = book[:volumeInfo][:authors]
        @published_date = book[:volumeInfo][:publishedDate]
        @genre = book[:volumeInfo][:categories]
        @synopsis = book[:volumeInfo][:description]
        @link = book[:selfLink]
        @@results << self
    end

    def self.all
        @@results
    end

    def self.clear_results
        self.all.clear
    end

end