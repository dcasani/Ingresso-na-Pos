class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :nome_completo
      t.date :data_de_nascimento
      t.string :estado_civil
      t.integer :identidade
      t.string :tipo
      t.integer :cpf
      t.string :nacionalidade
      t.string :logradouro_permanente
      t.integer :numero_permanente
      t.string :cidade_permanente
      t.string :estado_permanente
      t.string :pais_permanente
      t.integer :cep_permanente
      t.integer :telefone_permanente
      t.string :logradouro_correspondencia
      t.integer :numero_correspondencia
      t.string :cidade_correspondencia
      t.string :estado_correspondencia
      t.string :pais_correspondencia
      t.integer :cep_correspondencia
      t.integer :telefone_correspondencia
      t.integer :celular_correspondencia
      t.string :email
      t.text :formacao_superior_graduacao
      t.text :formacao_superior_pos
      t.text :outras_academicas
      t.text :empregos_passados
      t.text :empregos_atuais

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
