class Hashandletter < ActiveRecord::Migration
  def self.up
    add_column :reference_teachers, :hash, :string
    add_column :reference_teachers, :tempo, :string
    add_column :reference_teachers, :relacao, :string
    add_column :reference_teachers, :background, :string
    add_column :reference_teachers, :potencial, :string
  end


  def self.down
  end
end
