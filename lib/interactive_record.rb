require_relative "../config/environment.rb"
require 'active_support/inflector'
require 'pry'

class InteractiveRecord

  def self.table_name
    binding.pry
    self.downcase.pluralize
    
  end
end
