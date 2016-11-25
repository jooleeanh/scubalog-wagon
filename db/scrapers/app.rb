require_relative 'view'
require_relative 'router'
require "pry-byebug"

view = View.new
router = Router.new(view)
router.run
