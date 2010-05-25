class DeletaDadosCartaRecomendacao < ActiveRecord::Migration
  def self.up
    remove_column :subscriptions, :dados_carta_recomendacao
  end

  def self.down
  end
end
