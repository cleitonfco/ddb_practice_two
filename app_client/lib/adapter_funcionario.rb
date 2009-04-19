require 'active_record'

ActiveRecord::Base.pluralize_table_names = false
ActiveRecord::Base.establish_connection(
  :adapter => "postgresql",
  :host => "localhost"
  :encoding => "unicode",
  :database => "funcionario",
  :usernam => "postgres",
  :password => "post123",
  :pool => "5"
)

class AdapterFuncionario
end

class Funcionario < ActiveRecord::Base
  set_table_name "Funcionarios"
  set_primary_key "identificacao"
end
