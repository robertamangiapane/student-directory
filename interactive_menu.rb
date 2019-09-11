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
  puts "9. Exit"
end

def process(selection)
  # 3. do what the user has asked
  case selection
    when "1"
      @students = input_students
    when "2"
      show_students
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

def print_header
  puts "The students of Villains Academy"
  puts  "-------------"
end

def print_students_list
  @cohorts.each do |cohort|
    month = cohort
    group = ""
    @students.each do |student|
      if student[:cohort] == month
        group =  "#{group} #{student[:name]}, hobby: #{student[:hobby]}, age: #{student[:age]}, country of birth: #{student[:cob]};"
      end
    end
    if group == ""
      group = "No students for this cohort"
    end
      puts "#{month}: #{group}"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

interactive_menu