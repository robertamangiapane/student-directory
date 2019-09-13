def curr_exe_file(filename)
  file = File.open(filename, "r") 
  file.readlines.each do |line|
    puts line
  end
  file.close
end

filename = $0
curr_exe_file(filename)