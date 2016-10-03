#!/usr/bin/env ruby

Dir.chdir "/Users/andrew/vms"

vms = Dir.
  glob("*/").
  map { |e| e.gsub("/","") }

aliases = {}

vms.each do |name|
  index = 0
  done = false
  while (index < name.length) and not done do
    if aliases.keys.include? name[index]
      index += 1
      next
    end
    done = true
    aliases[name[index]] = {display: name.dup.insert(index, '(').insert(index+2, ')'),
      name: name}
  end
end

selected = ARGV[0]

if not selected
  puts "Select desired virtual machine:"
  puts aliases.values.map { |e| " #{e[:display]}" }
  puts
  print "> "
  selected = gets.chomp
end

vmname = aliases[selected][:name]
Dir.chdir "/Users/andrew/vms/#{vmname}"
puts "Selected #{vmname} VM"

puts "Checking whether #{vmname} VM is running..."

running = `vagrant status`.include? "running"

if not running
  puts "#{vmname} VM is not running. Starting up..."
  system "vagrant up"
end

puts "Connecting to the #{vmname} VM via SSH..."

system "vagrant ssh"
