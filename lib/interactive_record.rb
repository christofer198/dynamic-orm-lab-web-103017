require_relative "../config/environment.rb"
require 'active_support/inflector'
require 'pry'

class InteractiveRecord

  def self.table_name
    self.to_s.downcase.pluralize
  end

  def self.column_names
    sql = "PRAGMA table_info(#{self.table_name})"
    row = DB[:conn].execute(sql)
    column = row.collect {|row| row[1]}
    # column.delete('id')
    column
    #binding.pry
  end

  def initialize(attr={})
    attr.each {|key, value| self.send(("#{key}="), value)}

    #binding.pry
  end

end
