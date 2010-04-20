class Mymigration < ActiveRecord::Migration

  def self.up
    add_column :subscriptions, :diploma_file_name, :string
    add_column :subscriptions, :diploma_content_type, :string
    add_column :subscriptions, :diploma_file_size, :integer
    add_column :subscriptions, :historico_file_name, :string
    add_column :subscriptions, :historico_content_type, :string
    add_column :subscriptions, :historico_file_size, :integer
    add_column :subscriptions, :poscomp_file_name, :string
    add_column :subscriptions, :poscomp_content_type, :string
    add_column :subscriptions, :poscomp_file_size, :integer

  end

  def self.down
    remove_column :subscriptions, :diploma_file_name
    remove_column :subscriptions, :diploma_content_type
    remove_column :subscriptions, :diploma_file_size
    remove_column :subscriptions, :historico_file_name
    remove_column :subscriptions, :historico_content_type
    remove_column :subscriptions, :historico_file_size
    remove_column :subscriptions, :poscomp_file_name
    remove_column :subscriptions, :poscomp_content_type
    remove_column :subscriptions, :poscomp_file_size
  end

end
