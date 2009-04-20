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

ActiveRecord::Schema.define(:version => 2) do

  create_table "funcionarios", :primary_key => "identificacao", :force => true do |t|
    t.string   "nome",        :limit => 40
    t.string   "cpf",         :limit => 11
    t.decimal  "remuneracao"
    t.string   "logradouro",  :limit => 30
    t.integer  "numero"
    t.string   "bairro",      :limit => 20
    t.integer  "cep"
    t.string   "cidade",      :limit => 30
    t.string   "estado",      :limit => 2
    t.string   "telefone",    :limit => 10
    t.date     "data_nasc"
    t.integer  "sexo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
