require 'nokogiri'

XPATH_NODE_TAG = 'note'
XPATH_ATTR_NAME = 'type'
XPATH_ATTR_FILER = 'input'

namespace :import do
  desc "import tandem params from a sample default xml file"
  task :tandem_params => :environment do
    puts "imports parameters from tandem xml file and attaches them to protocol"
    puts "usage: rake import:tandem_params protocol_id=<id> <xml_file>"
    # first fetch protocol 
    protocol_id = 0
    file = ''
    ARGV.each do |a|
      if a =~ /protocol_id=(\d+)/
        protocol_id = $1
      else
        file = a
      end
    end
    if protocol_id == 0
      puts "Using last Protocol."
      prot = Protocol.last
    else
      prot = Protocol.find(protocol_id.to_i)
    end

    throw "Could not find protocol" if prot.nil?
    # import xml file
    doc = Nokogiri::XML(File.read(file))
    na = doc.xpath("//#{XPATH_NODE_TAG}[@#{XPATH_ATTR_NAME}='#{XPATH_ATTR_FILER}']")
    
    new_labels_hash = {}
    
    #loop through each node and set parameter for that protocol
    na.each do |node|
       # first find the last parameter for the protocol
       prot.reload
       
       if prot.parameters.empty?
         position = 1
       else
         last_param = prot.parameters.last
         position = last_param.position + 1 
       end
       
       #store whats in the tag
       node_value = node.content
       
       # now create parameter, store new label
       label = node['label']
       new_label = label.gsub(/[\W]/, ' ').split(' ').join('_')
       new_labels_hash[label] = new_label 
       
       param = Parameter.new({ :field_label => label,
                               :var_name => new_label,
                               :initial_value => node_value,
                               :position => position,
                               :field_type => "text",
                               :protocol => prot })
                               
       param.save
    
    end
    
    # now lets go back and print an updated version of the params file
    
    File.open(file).each do |l|
      
      if l =~ /<note type="input" label="(.+)">.*<\/note>/
        puts "<note type=\"input\" label=\"#{$1}\"><%= values[:#{new_labels_hash[$1]}] %></note>"
      else
        puts l
      end
      
    end
  
  end

end

