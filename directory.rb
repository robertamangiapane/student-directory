@students = []
require 'date'
require 'csv'
@cohorts = Date::MONTHNAMES.compact

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to a file"
  puts "4. Load the list from a file"
  puts "9. Exit"
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      puts "Type the name of the file you want to load"
      filename = STDIN.gets.chomp
      load_students("#{filename}.csv")
    when "9"
      exit 
    else
      puts "I don't know what you meant, try again"
  end
end    

def input_students
  puts "Please enter the names of the student"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  while !name.empty? do
    puts "Enter hobby: "
    hobby = STDIN.gets.chomp
    if hobby == ""
      hobby = "N/A"
    end
    puts "Enter age: "
    age = STDIN.gets.chomp
    if age.to_i == 0
      age = "N/A"
    end
    puts "Enter country of birth: "
    cob = STDIN.gets.chomp
    if cob == ""
      cob = "N/A"
    end
    puts "Enter cohort: "
    cohort = STDIN.gets.chomp.capitalize
    while !@cohorts.include? cohort
      loop do
        puts "Enter cohort: "
        cohort = STDIN.gets.chomp.capitalize
        if @cohorts.include? cohort
          break
        end
      end
    end  
    @students << {name: name, hobby: hobby, age: age, cob: cob, cohort: cohort}
    if @students.count == 1
      puts "Now we have #{@students.count} student in the list"
    else
      puts "Now we have #{@students.count} students in the list"
    end
    puts "Enter students' name"
    name = STDIN.gets.chomp
  end
end

def show_students
  if @students.count == 0
    puts "There are no students to show"
  else
    print_header
    print_students_list
    print_footer
  end
end 

def save_students
  if @students.count != 0
    puts "Type the name of the file you want to save"
    filename = STDIN.gets.chomp
    CSV.open("#{filename}.csv", "wb") do |file|
      @students.each do |student|
        student_data = [student[:name], student[:hobby], student[:age], student[:cob], student[:cohort]]
        file << student_data
      end
    end
    puts "You saved the students' list"
  else
    puts "There is no list to save"
  end
end

def try_load_students
  filename = "students.csv"
  return if filename.nil?
  if File.exist?(filename)
    load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, tried to load #{filename} but it doesn't exist."
  end
end

def load_students(filename)
  if File.exist?(filename)
    CSV.foreach(filename) do |line|
      name, hobby, age, cob, cohort = line
        @students << {name: name, hobby: hobby, age: age, cob: cob, cohort: cohort}
    end
    if @students.count != 1
      puts "Loaded #{@students.count} students from #{filename}"
    else
      puts "Loaded #{@students.count} student from #{filename}"
    end
  else
    puts "Sorry, #{filename} doesn't exist."
  end
end
  
def print_header
  puts "The students of Villains Academy"
  puts  "-------------"
end

def print_students_list
  @cohorts.each do |cohort|
    group = ""
    @students.each do |student|
      if student[:cohort] == cohort
        group += "#{student[:name]}, #{student[:hobby]}, #{student[:age]}, #{student[:cob]}; "
      end
    end
    if group == ""
      group = "No students for this cohort"
    end
      puts "#{cohort}: #{group}"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

try_load_students
interactive_menu