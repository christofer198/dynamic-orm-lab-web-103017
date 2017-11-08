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
    #column.delete('id')
    column
    #binding.pry
  end

  def self.inherited(childclass)
    childclass.column_names.each do |key|
      attr_accessor key.to_sym
    end
  end

  def initialize(attributes={})
    attributes.each {|key, value| self.send(("#{key}="), value)}
  end

  def table_name_for_insert
    self.class.table_name
  end

  def col_names_for_insert
    column_names = self.class.column_names
    column_names.delete('id')
    column_names.join(', ')
  end

  def values_for_insert
    #binding.pry
    data = []
    x = col_names_for_insert.split(', ')
    x.each{|name| data << send("#{name}")}
    data.collect{|each| "'#{each}'"}.join(", ")
  end

  def save
    sql = "INSERT INTO #{table_name_for_insert} (#{col_names_for_insert}) VALUE (#{values_for_insert})"

  end

end
