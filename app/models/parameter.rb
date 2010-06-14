class Parameter < ActiveRecord::Base
  belongs_to :protocol

  validates_presence_of :var_name, :field_label
  validates_format_of :var_name, :with => /^\S+$/i, :allow_blank => true, :message => "cannot contain whitespaces"


end
