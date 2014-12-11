require 'xml_ripper_v3'

  ripper = XmlRipper.new do |r|
    puts "Compiling  ..."
    r.on_path '/document/title' do |t| 
      puts "Title: "+t.text 
    end
    r.on_path '/document/author' do |a| 
      puts "Author: "+a.text 
    end
    r.action { puts "Chapters: " }
    r.on_path '/document/chapter/title' do |ct| 
      puts "  "+ct.text 
    end
  end
  filename = ARGV.shift || 'fellowship.xml'
  ripper.run filename
  #  Compiling  ...
  #  Title: The Fellowship of the Ring
  #  Author: J. R. R. Tolken
  #  Chapters: 
  #    A Long Expected Party
  #    A Shadow Of The Past

