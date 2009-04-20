class CreateEmpregados < ActiveRecord::Migration
  def self.up
    create_table :empregados, :id => false do |t|
      t.primary_key :matricula
      t.string :nome, :limit => 40
      t.integer :cpf
      t.decimal :salario, :precision => 10, :scale => 2
      t.string :endereco, :limit => 60
      t.string :cidade, :limit => 20
      t.string :estado, :limit => 2
      t.string :fone_res, :limit => 10
      t.string :fone_cel, :limit => 10
      t.integer :dia_nasc
      t.integer :mes_nasc
      t.integer :ano_nasc
      t.string :sexo, :limit => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :empregados
  end
end

