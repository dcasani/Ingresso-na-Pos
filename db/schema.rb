# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100406173914) do

  create_table "courses", :force => true do |t|
    t.string   "area"
    t.string   "nivel"
    t.string   "subarea"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", :force => true do |t|
    t.string   "inicio_pretendido"
    t.text     "outros_programas"
    t.string   "orientador"
    t.string   "bolsa_fomento"
    t.boolean  "bolsa_ime"
    t.text     "bolsas_anteriores"
    t.text     "dados_carta_recomendacao"
    t.boolean  "trabalhar_se_aceito"
    t.text     "resumo_dissertacao_mestrado"
    t.text     "propositos"
    t.text     "observacoes"
    t.integer  "curso_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "nome_completo"
    t.date     "data_de_nascimento"
    t.string   "estado_civil"
    t.integer  "identidade"
    t.string   "tipo"
    t.integer  "cpf"
    t.string   "nacionalidade"
    t.string   "logradouro_permanente"
    t.integer  "numero_permanente"
    t.string   "cidade_permanente"
    t.string   "estado_permanente"
    t.string   "pais_permanente"
    t.integer  "cep_permanente"
    t.integer  "telefone_permanente"
    t.string   "logradouro_correspondencia"
    t.integer  "numero_correspondencia"
    t.string   "cidade_correspondencia"
    t.string   "estado_correspondencia"
    t.string   "pais_correspondencia"
    t.integer  "cep_correspondencia"
    t.integer  "telefone_correspondencia"
    t.integer  "celular_correspondencia"
    t.string   "email"
    t.text     "formacao_superior_graduacao"
    t.text     "formacao_superior_pos"
    t.text     "outras_academicas"
    t.text     "empregos_passados"
    t.text     "empregos_atuais"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
