# frozen_string_literal: true

module MyLibrary
  # Book to store the information of the book i.e. isbn, author, title
  class Book
    attr_reader :isbn, :author, :title

    def initialize(params)
      @isbn = params[:isbn]
      @author = params[:author]
      @title = params[:title]
    end

    def valid?
      return false if @isbn == '' || @author == '' || @title == ''
      return false if @isbn.length != 13 || !numeric?(@isbn)

      true
    end

    def numeric?(string)
      string.scan(/\D/).empty?
    end

    def ==(other)
      other.isbn == @isbn
    end

    def to_s
      "#{@isbn} | #{@title} | #{@author}"
    end

    def title_contains(keyword)
      @title.downcase.include?(keyword.downcase)
    end

    def author_contains(keyword)
      @author.downcase.include?(keyword.downcase)
    end

    private :numeric?
  end
end
