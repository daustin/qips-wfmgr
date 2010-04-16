require 'erubis'

class Task < ActiveRecord::Base
  
  belongs_to :submission
  belongs_to :protocol
    
  serialize :param_values
  serialize :aux_files

  before_save :generate_vars #do erb translation, generate params_url from timestamp

  
  def generate_vars
    #first lets generate the params url
    unless params_url.blank?
      
      prefix = "#{S3_SCRATCH_SPACE.chomp('/')}/#{Time.now.to_f}"
      basename = params_url.strip
      self.params_url = "#{prefix}/#{params_url}" unless params_url =~ /#{S3_SCRATCH_SPACE}/
      # now lets do the tough erb translation
      value_hash = param_values ||= Hash.new
      eruby = Erubis::Eruby.new(protocol.params_template)
      self.params_contents = eruby.result(:values => value_hash)
    
      # done now lets upload
    
      S3Helper.upload(prefix, basename, self.params_contents)
    
    end
  end
    
  
end
