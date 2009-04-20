class CreateFuncionarios < ActiveRecord::Migration
  def self.up
    create_table :funcionarios, :id => false do |t|
      t.primary_key :identificacao
      t.string :nome, :limit => 40
      t.string :cpf, :limit => 11
      t.decimal :remuneracao
      t.string :logradouro, :limit => 30
      t.integer :numero
      t.string :bairro, :limit => 20
      t.integer :cep
      t.string :cidade, :limit => 30
      t.string :estado, :limit => 2
      t.string :telefone, :limit => 10
      t.date :data_nasc
      t.integer :sexo

      t.timestamps
    end
  end

  def self.down
    drop_table :funcionarios
  end
end

