class DeletaCpf < ActiveRecord::Migration

  def self.up
    remove_column :users, :cpf
    add_column    :users, :cpf, :string
  end

  def self.down
    remove_column :users, :cpf
  end
end
