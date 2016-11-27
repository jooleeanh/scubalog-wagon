require_relative 'controller'

class Router

  def initialize(view)
    @view = view
    @controller = Controller.new(view)
  end

  def run
    loop do
      input = -1
      while input < 0 || input > @view.choices.size
        @view.greeting
        @view.print_choices
        input = @view.get_index
      end
      dispatch(input)
    end
  end

  private

  def dispatch(input)
    case input
    when 0 then
      puts "\n"
      exit
    when 1 then @controller.parse_freediving_example
    when 2 then @controller.parse_scuba_example
    when 3 then @controller.parse_all
    when 4 then @controller.view_parsed_example
    when 5 then @controller.reformat_hash
    end
  end
end
