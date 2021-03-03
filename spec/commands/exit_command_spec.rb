# frozen_string_literal: true

require '../class/commands/exit_command'

RSpec.describe 'ExitCommand' do
  describe '#args_valid?' do
    it 'always return true' do
      command = ExitCommand.new
      args = []
      expect(command.args_valid?(args)).to eq(true)
    end
  end

  describe '#execute' do
    it 'raised SystemExit when command is exit' do
      command = ExitCommand.new
      expect { command.execute }.to raise_error(SystemExit)
    end
  end
end
