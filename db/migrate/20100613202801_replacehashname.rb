class Replacehashname < ActiveRecord::Migration
  def self.up
    remove_column :reference_teachers, :hash
    add_column :reference_teachers, :hashcode, :string
  end

  def self.down
  end
end
