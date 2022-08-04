class TestsController < ApplicationController
	include ModuleTest

	def index
		print_test
	end
end
