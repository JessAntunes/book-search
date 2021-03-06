
class Cli

    def display_welcome
        puts 
        puts 
        puts "___________________________________________________________________________"
        puts "|                                                                          |"
        puts "|                                                                          |"
        puts "|                                                                          |"
        puts "|                                                                          |"
        puts "|                         " + "Welcome to Book Search".green + "                           |"
        puts "|                                                                          |"
        puts "|                                                                          |"
        puts "|                                                                          |"
        puts "|                " + "Enter your books title or keywords below:".green + "                 |"
        puts "|                                                                          |"
        puts "|                                                                          |"
        puts "'~^-~^~^~--^~^~~~^~^-~^~^~--^~^^-~^~^~~--^~^^~^~-~^^-~^~^~-~^-~^~^~--^~^-~^'"
        puts 
        puts 
    end

    def search_by_title(title)
        uri = URI('https://www.googleapis.com/books/v1/volumes?q={search_terms}')
        params = { :q => title, :maxResults => 10, :authorization => "Bearer #{ENV['API_KEY']}"}
        uri.query = URI.encode_www_form(params)
        resp = Net::HTTP.get_response(uri)
        results_hash = JSON.parse(resp.body, symbolize_names: true)
        results_hash[:items].each do |book|
            Book.new(book)
        end
    end

    def display_book_info(index)
        book = Book.all[index]
        puts 
        puts "._^~^-~^~^~--^^~^~^~^^~^~^~^-~^~^~--^~^~^~-^~^^-^-~^~-~^~^^-~^~^~--^^~^~-^~|"
        puts "|                                                                          |"
        puts 
        puts "      #{book.title}".green.summary(75)
        puts 
        if book.authors
            puts " Author: #{book.authors.join(", ")}".green
            puts 
        end
        if book.published_date
            puts " Published: #{book.published_date}".green
            puts 
        end
        if book.genre
            puts " Genre: #{book.genre.join(", ")}".green
            puts 
        end
        if book.synopsis
            synopsis = Linesetter.format(book.synopsis)
            puts " Synopsis: ".green
            puts "      #{synopsis}".green

            
            puts 
        end
        puts " View more info at #{book.link}.".green
        puts
        puts "|                                                                          |"
        puts "|                                                                          |"
        puts "'~^-~^~^~--^~^~~~^~^-~^~^~--^~^^-~^~^~~--^~^^~^~-~^^-~^~^~-~^-~^~^~--^~^-~^'"
        puts 
    end

    def display_results_list
        Book.all.each.with_index(1) { |book, index| puts "     #{index}. #{book.title}".green.summary(78)}
    end

    def get_input
        input = gets.chomp
        puts 
        return input
    end

    def input_to_index(input)
        input.to_i - 1
    end 

    def number_selection
        puts 
        puts "Enter a number to view more info about the book or SEARCH to search again:"
        input = gets.chomp
        if input == "SEARCH" || input == "search"
            Book.clear_results
            search
        elsif input.count("a-zA-Z") > 0 
            number_selection
        elsif input.to_i < 1 || input.to_i > 10
            number_selection
        end
        input
    end

    def results_menu
        puts 
        puts "._^~^-~^~^~--^^~^~^~^^~^~^~^-~^~^~--^~^~^~-^~^^-^-~^~-~^~^^-~^~^~--^^~^~-^~|"
        puts "|                                                                          |"
        puts 
        puts "                  Here are your results:".green
        puts 
        display_results_list
        puts
        puts "|                                                                          |"
        puts "|                                                                          |"
        puts "'~^-~^~^~--^~^~~~^~^-~^~^~--^~^^-~^~^~~--^~^^~^~-~^^-~^~^~-~^-~^~^~--^~^-~^'"
        puts 
    end

    def search_again
        puts 
        puts "Enter SEARCH to search again, BACK to return to results, or EXIT to exit this program:"
        input = gets.chomp
        if input == "search" || input == "SEARCH"
            Book.clear_results
            search
        elsif input == "back" || input == "BACK"
            interactive_results_list
        elsif input == "exit" || input == "EXIT"
            exit
        else
            search_again
        end
    end

    def interactive_results_list
        results_menu
        input = number_selection
        index = input_to_index(input)
        display_book_info(index)
        search_again
    end

    def search
        display_welcome
        title = get_input
        search_by_title(title)
        interactive_results_list
    end
         

end