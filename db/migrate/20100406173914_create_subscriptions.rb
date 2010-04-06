class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.string :inicio_pretendido
      t.text :outros_programas
      t.string :orientador
      t.string :bolsa_fomento
      t.boolean :bolsa_ime
      t.text :bolsas_anteriores
      t.text :dados_carta_recomendacao
      t.boolean :trabalhar_se_aceito
      t.text :resumo_dissertacao_mestrado
      t.text :propositos
      t.text :observacoes
      t.integer :curso_id
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :subscriptions
  end
end
