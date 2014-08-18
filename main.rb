require 'net/http'
require 'colorize'
 
# find all available three-letter .io domains
alph = ('a'..'z')
# generate all three-character strings
threes = alph.map { |a| alph.map { |b| alph.map { |c| "#{a}#{b}#{c}" } } }.flatten
 
def io_available?(tld)
  url = URI.parse("http://www.nic.io/cgi-bin/whois?query=#{tld}.io") 
  html = Net::HTTP.get(url)
  if html =~ /Domain Available/
    return true
  else
    return false
  end
end
 
avail_threes = [] 
 
# output which are available and which are not
threes.each do |t| 
  if io_available? t
    avail_threes << t
    puts "#{t}.io".green
  else
    puts "#{t}.io".red
  end
end
 
# store available ones in a file
File.open('avail_threes.txt', 'w') do |f|
  avail_threes.each do |a|
    f.write("#{a}.io\n")
  end
end