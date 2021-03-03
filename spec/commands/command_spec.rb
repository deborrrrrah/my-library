# frozen_string_literal: true

require './spec/spec_helper'

RSpec.describe MyLibrary::Command do
  describe '#args_valid?' do
    it 'raised NotImplementedError when not override' do
      command = MyLibrary::Command.new
      args = {}
      expect { command.args_valid?(args) }.to raise_error(NotImplementedError)
    end
  end

  describe '#execute' do
    it 'raised NotImplementedError when not override' do
      command = MyLibrary::Command.new
      args = {}
      expect { command.execute(args) }.to raise_error(NotImplementedError)
    end
  end
end
