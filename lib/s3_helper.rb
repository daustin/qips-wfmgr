require 'right_aws'

#################################################
###
##     David Austin - ITMAT @ UPENN
#      S3 Helper  downloads and uploads files 
#
#
####  

class S3Helper

    @s3 = RightAws::S3.new(AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY)

 

  def self.upload(prefix, filename, contents)
    # upload all files in cwd to folder, except the ones in exclude list
    return nil unless validate_s3(prefix)
    b =  prefix.split(':')[0]
    k =  "#{prefix.split(':')[1]}/#{filename}"
    bucket = RightAws::S3::Bucket.create(@s3, b, true)
    key = RightAws::S3::Key.create( bucket,"#{k}")
    key.data = contents
    key.put
    
  end


  def self.validate_s3 (s)
    if s.index(':').nil?
      # invalid bucket!
      return false
    else
      return true
    end
    
  end
  


end
