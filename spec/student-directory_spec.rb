require 'student-directory'

describe 'Student directory'  do
	it 'can take user input' do
		expect($stdin).to receive(:gets).and_return("")
		take_user_input
	end	

	it 'removes the new line when getting user input' do
		input = "hello\n"
		allow($stdin).to receive(:gets).and_return(input)
		expect(take_user_input).to eq 'hello'
	end

	it 'prints a string to the terminal' do
		expect(self).to receive(:puts).with('O HAI')
		show('O HAI')
	end

	it 'prints the header' do
		header = "Welcome to Student Directory\nPlease input something"
		expect(self).to receive(:show).with(header)
		print_header
	end
end