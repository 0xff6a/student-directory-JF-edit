def print_header
	puts "The students of my cohort at Makers Academy"
	puts "-----------------"
end

def display_students
	months = @students.map { |student| student[:cohort] }.uniq 
	months.each do |month|
		puts "The students in the #{month.to_s} cohort are:" 
		@students.each { |student| puts "#{student[:name]}, #{student[:age]}, #{student[:cohort]}" if student[:cohort] == month }
	end
end

def print_footer
  if !@students.empty? 
    puts "Overall, we have #{@students.length} great student#{@students.length > 1 ? "s" : ""}\n"
  else
    puts "No students in your cohort :("
  end
end

def input_name
		puts "Please enter your name"
		# get the first name
		name = STDIN.gets.chomp
end

def input_age
	puts "Please enter your age"
	age = STDIN.gets.chomp
	while ( age.to_i == 0 || age.to_i < 0 )
		puts "Please enter a numeric value for your age"
		age = STDIN.gets.chomp
	end

	age
end

def input_cohort
	puts "Please enter a number between 1-12 for the month of your cohort (1-January, etc)"
	# get cohort month, if nothing entered default to 6 (june)
	cohort = STDIN.gets.chomp
	if cohort.empty?
		cohort = "6" 
	end

	cohort = (Time.new(Time.now.year, cohort.to_i).strftime "%B").to_sym
end

def confirm_and_save_input(name, age, cohort)
	puts "Your input is #{name}, #{age}, #{cohort}. Are you sure? (y/n)"
	confirmation = STDIN.gets.chomp
	
	if confirmation == "y"
		update_students_hash(name, age, cohort) 
		puts "Now we have #{@students.length} student#{@students.length > 1 ? "s" : ""}"
	elsif confirmation == "n"
		puts "Please re-enter your name"
		name = STDIN.gets.chomp
	end

end

def update_students_hash(name, age, cohort)
	@students << {:name => name, :age => age, :cohort => cohort.to_sym}
end

def input_students
	get_students_info(name = input_name)
	@students
end

def get_students_info(name)
	while !name.empty? do
		age = input_age
		cohort = input_cohort
		confirm_and_save_input(name, age, cohort)
		puts "Please enter another name OR press return for Menu"
		name = STDIN.gets.chomp
	end
end

def print_menu
		puts "\n--------MENU---------"
		puts "1. Input the students"
		puts "2. Show the students"
		puts "3. Save the list to students.csv"
		puts "4. Load the list from students.csv"
		puts "9. Exit" # 9 because we'll be adding more items
		puts "---------------------\n"
end

def show_students
	print_header
	display_students
	print_footer
end

def process(selection)
	case selection
		when "1"
			@students = input_students
		when "2"
			show_students
		when "3"
			save_students
		when "4"
			load_students
		when "9"
			exit # this will cause the program to terminate
	else
		puts "I don't know what you meant, try again"
	end
end

def save_students
	# open the file for writing
	file = File.open("students.csv", "w")
	# iterate over the array of students
	@students.each do |student|
		file.puts [student[:name], student[:age], student[:cohort]].join(",")
	end
	file.close
end

def load_students(filename = "students.csv")
	file = File.open(filename, "r")
	file.readlines.each do |line|
		name, age, cohort = line.chomp.split(',')
			update_students_hash(name, age, cohort)
	end
	file.close
end

def try_load_students
	filename = ARGV.first
	return if filename.nil?
	if File.exists?(filename)
		load_students(filename)
		puts "Loaded #{@students.length} from #{filename}"
	else
		puts "Sorry #{filename} does not exist"
		exit
	end
end

def interactive_menu
	@students = []
	try_load_students
	loop do
		# 1. print the menu and ask the user what to do
		print_menu
		# 2. read the input and save it into a variable
		process(STDIN.gets.chomp)
	end
end

#nothing happens until we call the methods
interactive_menu