@students = []
require 'date'
@cohorts = Date::MONTHNAMES.compact

def interactive_menu
  loop do
    print_menu
    # 2. read the input and save it into a variable
    process(gets.chomp)
  end
end

def print_menu
  # 1. print the menu and ask the user what to do
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def process(selection)
  # 3. do what the user has asked
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
      exit 
      #this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
  end
end    

def input_students
  puts "Please enter the names of the students, hobbies, age, country of birth and cohort"
  puts "To finish, just hit return twice"
  name = gets.chomp
  while !name.empty? do
    puts "Enter hobby: "
    hobby = gets.chomp
    if hobby == ""
      hobby = "N/A"
    end
    puts "Enter age: "
    age = gets.chomp
    if !age.is_a? Integer
      age = "N/A"
    end
    puts "Enter country of birth: "
    cob = gets.chomp
    if cob == ""
      cob = "N/A"
    end
    puts "Enter cohort: "
    cohort = gets.chomp.capitalize
    while !@cohorts.include? cohort
      loop do
        puts "Enter cohort: "
        cohort = gets.chomp.capitalize
        if @cohorts.include? cohort
          break
        end
      end
    end  
    @students << {name: name, hobby: hobby, age: age, cob: cob, cohort: cohort}
    if @students.count == 1
      puts "Now we have #{@students.count} student"
    else
      puts "Now we have #{@students.count} students"
    end
    puts "Enter students' name"
    name = gets.chomp
  end
  @students
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
  #open the file for writing
  file = File.open("students.csv", "w")
  #iterate over the array of students
  @students.each do |student|
    student_data = "#{student[:name]}, #{student[:hobby]}, #{student[:age]}, #{student[:cob]}, #{student[:cohort]}"
    file.puts student_data
  end
  file.close
end

def load_students
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
    name, hobby, age, cob, cohort = line.chomp.split(", ")
      @students << {name: name, hobby: hobby, age: age, cob: cob, cohort: cohort}
    end
    file.close
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
        group +=  "#{student[:name]}, #{student[:hobby]}, #{student[:age]}, #{student[:cob]}; "
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

interactive_menu