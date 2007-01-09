class CreateReferenceTeachers < ActiveRecord::Migration
  def self.up
    create_table :reference_teachers do |t|
      t.string :nome
      t.string :instituicao
      t.string :email
      t.references :subscription

      t.timestamps
    end
  end

  def self.down
    drop_table :reference_teachers
  end
end
