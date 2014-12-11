This repo implements a DSL for the processing
of XML documents like this one:

    [~/chapter8ReflectionandMetaprogramming/DSL/xmlripper(master)]$ cat fellowship.xml 
    <?xml version="1.0" encoding="UTF-8" ?>
      <document>
        <title>The Fellowship of the Ring</title>
        <author>J. R. R. Tolken</author>
        <published>1954</published>
        
        <chapter>
          <title>A Long Expected Party</title>
          <content>When Mr. Bilbo Bagins from Bag End ...</content>
        </chapter>

        <chapter>
          <title>A Shadow Of The Past</title>
          <content>The talk did not die down ...</content>
        </chapter>

        <!-- etc -->
      </document>


Here is an script written using the implemented DSL:

      puts "Compiling  ..."
      on_path '/document/title' do |t| 
        puts "Title: "+t.text 
      end
      on_path '/document/author' do |a| 
        a.text = "J.R.R. Tolkien"
        puts "Author: "+a.text 
      end
      action { puts "Chapters: " }
      on_path '/document/chapter/title' do |ct| 
        puts "  "+ct.text 
      end

And here is an example of execution:

      $ ./xripper sample.xr fellowship.xml 
      Compiling  ...
      Title: The Fellowship of the Ring
      Author: J.R.R. Tolkien
      Chapters: 
        A Long Expected Party
        A Shadow Of The Past

See [Russ Olsen. 
Eloquent Ruby. 
Addison-Wesley Professional, 1st edition, 2011.](http://eloquentruby.com/)
