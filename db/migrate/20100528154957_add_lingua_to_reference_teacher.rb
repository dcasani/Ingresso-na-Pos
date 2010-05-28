class AddLinguaToReferenceTeacher < ActiveRecord::Migration
  def self.up
    add_column :reference_teachers, :lingua, :string
  end

  def self.down
    remove_column :reference_teachers, :lingua
  end
end
