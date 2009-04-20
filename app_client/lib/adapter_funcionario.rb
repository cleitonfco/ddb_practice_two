require 'active_record'

ActiveRecord::Base.pluralize_table_names = false
ActiveRecord::Base.establish_connection :postgres

class AdapterFuncionario
end

class Funcionario < ActiveRecord::Base
  set_table_name "funcionarios"
  set_primary_key :identificacao
end

