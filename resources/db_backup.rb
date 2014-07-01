actions :create
default_action :create

attribute :name, :kind_of => String, :name_attribute => true, :required => true
attribute :group, :kind_of => String
attribute :databases, :kind_of => Hash, :required => true

attr_accessor :exists
