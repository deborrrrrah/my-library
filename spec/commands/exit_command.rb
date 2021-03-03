# frozen_string_literal: true

require '../class/commands/exit_command'

RSpec.describe 'ExitCommand' do
  describe '#execute' do
    it 'raised SystemExit when command is exit' do
      command = ExitCommand.new
      expect { command.execute }.to raise_error(SystemExit)
    end
  end
end
