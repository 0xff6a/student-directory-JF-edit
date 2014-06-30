def students
	[{:name=> "Enrique", :cohort=> june}]
end

def take_user_input(input = $stdin)
	input.gets.chomp
end

def show(str)
	puts str
end

def print_header
	show("Welcome to Student Directory\nPlease input something")
end