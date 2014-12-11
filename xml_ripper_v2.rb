require 'rexml/document'

class XmlRipper
  
  def initialize( path = nil, &block )
    @before_action = proc { } # do nothing
    @path_action   = []       # Array: to preserve the order
    @after_action  = proc { }

    if path then
      instance_eval( File.read( path ) )
    else
      instance_eval( &block ) if block_given?
    end
  end

  def on_path(path, &block)
    @path_action << [ path, block ]
  end

  def action(&block)
    @path_action << [ '', block ]
  end

  def before(&block)
    @before_action = block
  end

  def after(&block)
    @after_action = block
  end

  def run_path_actions(doc)
    @path_action.each do |path_action|
      path, action = path_action
      REXML::XPath.each(doc, path) do |element|
        action[element]
      end
    end
  end

  def run(file_name)
    File.open(file_name) do |f|
      doc = REXML::Document.new(f)
      @before_action[doc]
      run_path_actions(doc)
      @after_action[doc]
    end
  end

end
if $0 == __FILE__
  ripper = XmlRipper.new do 
    puts "Compiling  ..."
    on_path '/document/title' do |t| 
      puts "Title: "+t.text 
    end
    on_path '/document/author' do |a| 
      puts "Author: "+a.text 
    end
    action { puts "Chapters: " }
    on_path '/document/chapter/title' do |ct| 
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
end

