
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

    def self.display_book_info(index)
        book = self.all[index]
        puts 
        puts "._^~^-~^~^~--^^~^~^~^^~^~^~^-~^~^~--^~^~^~-^~^^-^-~^~-~^~^^-~^~^~--^^~^~-^~|"
        puts "|                                                                          |"
        puts 
        puts "      #{book.title}".green.summary(75)
        puts 
        if book.authors
            puts "  Author: #{book.authors.join(", ")}".green
            puts 
        end
        if book.published_date
            puts "  Published: #{book.published_date}".green
            puts 
        end
        if book.genre
            puts "  Genre: #{book.genre.join(", ")}".green
            puts 
        end
        if book.synopsis
            synopsis = Linesetter.format(book.synopsis)
            puts "  Synopsis: ".green
            puts "      #{synopsis}".green

            
            puts 
        end
        puts "  View more info at #{book.link}.".green
        puts
        puts "|                                                                          |"
        puts "|                                                                          |"
        puts "'~^-~^~^~--^~^~~~^~^-~^~^~--^~^^-~^~^~~--^~^^~^~-~^^-~^~^~-~^-~^~^~--^~^-~^'"
        puts 
    end

    def self.display_results_list
        self.all.each.with_index(1) { |book, index| puts "     #{index}. #{book.title}".green.summary(78)}
    end

    def self.all
        @@results
    end

    def self.clear_results
        self.all.clear
    end





end