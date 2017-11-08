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

    column = row.collect {|row| row[1]}.delete("id")
    binding.pry
    column

    #binding.pry

  end
end
