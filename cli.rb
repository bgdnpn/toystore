require "./toystore.rb"
require "./utils/utils.rb"

COMMANDS = {
  :random => "populate_with_random_data",
  :show => "show",
  :build => "build",
  :quit => "quit"
}

class CLI

  @ts = nil

  def build(file=nil)
    if @ts = ToyStore.new(file)
      log "ToyStore instance created: #{@ts}"
    end
  end

  def show(key=nil)
    puts @ts.rows
  end

  def add(key, value)
    @ts.upsert(key, value)
  end

  def interactive()
    command = nil
    loop do
      log "~ what would you like to do? #{COMMANDS.keys}"
      command = gets.chomp
      break if command == "quit"
      command_to_action command
    end
  end

  def command_to_action(command)
    eval COMMANDS[command.to_sym]
  end

end

cli = CLI.new()

cli.interactive()
