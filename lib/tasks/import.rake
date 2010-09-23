

begin
  require 'nokogiri'

  namespace :import do
    desc "import tandem params from a sample default xml file"
    task :tandem_params => :environment do
      puts "imports parameters from tandem xml file and attaches them to protocol"
      puts "usage: rake import:tandem_params --protocol_id==<id> <xml_file>"
      # first fetch protocol 
      protocol_id = 0
      file = ''
      ARGV.each do |a|
        if a =~ /--protocol_id==(\d+)/
          protocol_id = $1
        else
          file = a
        end
      end
      if protocol_id == 0
        prot = Protocol.last
      else
        prot = Protocol.find(protocol_id.to_i)
      end
      throw "Could not find protocol" if prot.nil?
      # import xml file
      doc = Nokogiri::XML(File.read(file))
      na = doc.xpath("//note[@type='input']")
      
      #loop through each node and set parameter for that protocol
      na.each do |node|
         # first find the last parameter for the protocol
         prot.reload
         last_param = prot.parameters.last
         position = last_param.position + 1
         
         # now create parameter
         label = node['label']
         la = label.gsub(/[\W]/, ' ')
         label.gsub!(/[\s]/, '_')
         
      
      
      
      end
      
      
      # first
    end

  end

rescue LoadError => e
  puts "Could not load: #{e.message}"
    
end
