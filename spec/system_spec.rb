# frozen_string_literal: true

require './spec/spec_helper'

RSpec.describe MyLibrary::System do
  describe '#execute' do
    it 'stub BuildLibraryCommand#execute when command is build_library' do
      command = 'build_library'
      args = %w[2 1 3]
      expect_any_instance_of(MyLibrary::BuildLibraryCommand).to receive(:execute).with(args)
      MyLibrary::System.instance.execute(command, args)
    end

    it 'stub FindBookCommand#execute when command is find_book' do
      command = 'find_book'
      args = ['9780807281918']
      expect_any_instance_of(MyLibrary::FindBookCommand).to receive(:execute).with(args)
      MyLibrary::System.instance.execute(command, args)
    end

    it 'stub ListBooksCommand#execute when command is list_books' do
      command = 'list_books'
      args = []
      expect_any_instance_of(MyLibrary::ListBooksCommand).to receive(:execute).with(args)
      MyLibrary::System.instance.execute(command, args)
    end

    it 'stub PutBookCommand#execute when command is put_book' do
      command = 'put_book'
      args = ['9780747532743', 'Harry Potter 1', 'J. K. Rowling']
      expect_any_instance_of(MyLibrary::PutBookCommand).to receive(:execute).with(args)
      MyLibrary::System.instance.execute(command, args)
    end

    it 'stub SearchBooksByAuthorCommand#execute when command is search_books_by_author' do
      command = 'search_books_by_author'
      args = ['Kent Beck']
      expect_any_instance_of(MyLibrary::SearchBooksByAuthorCommand).to receive(:execute).with(args)
      MyLibrary::System.instance.execute(command, args)
    end

    it 'stub SearchBooksByTitleCommand#execute when command is search_books_by_title' do
      command = 'search_books_by_title'
      args = ['Harry Potter']
      expect_any_instance_of(MyLibrary::SearchBooksByTitleCommand).to receive(:execute).with(args)
      MyLibrary::System.instance.execute(command, args)
    end

    it 'stub TakeBookCommand#execute when command is take_book_from' do
      command = 'take_book_from'
      args = ['010101']
      expect_any_instance_of(MyLibrary::TakeBookCommand).to receive(:execute).with(args)
      MyLibrary::System.instance.execute(command, args)
    end

    it 'raise ArgumentError due to invalid arguments type' do
      command = 'take_book_from'
      args = ['01aa01']
      expect { MyLibrary::System.instance.execute(command, args) }.to raise_error(ArgumentError)
    end

    it 'raise ArgumentError due to nil command for enter input' do
      command = nil
      args = []
      expect { MyLibrary::System.instance.execute(command, args) }.to raise_error(ArgumentError)
    end

    it 'raise ArgumentError when command destroy which is not recognized' do
      command = 'destroy'
      args = []
      expect { MyLibrary::System.instance.execute(command, args) }.to raise_error(ArgumentError)
    end

    it 'raised MyLibrary::SystemExit due to ExitCommand#execute' do
      command = 'exit'
      args = []
      expect { MyLibrary::System.instance.execute(command, args) }.to raise_error(SystemExit)
    end
  end
end
