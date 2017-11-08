require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord
  
  def self.table_name
    self.table_name.downcase.pluralize
  end
end
