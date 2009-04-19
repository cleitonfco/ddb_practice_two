require 'active_record'

ActiveRecord::Base.pluralize_table_names = false
ActiveRecord::Base.establish_connection(
  :adapter => "mysql",
  :encoding => "utf8",
  :database => "empregado",
  :usernam => "root",
  :password => "senha"
)

class AdapterEmpregado
end

class Empregado < ActiveRecord::Base
  set_table_name "Empregados"
  set_primary_key "matricula"
end
