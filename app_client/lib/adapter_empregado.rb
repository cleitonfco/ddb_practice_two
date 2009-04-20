require 'active_record'

ActiveRecord::Base.pluralize_table_names = false
ActiveRecord::Base.establish_connection :mysql

class AdapterEmpregado
end

class Empregado < ActiveRecord::Base
  set_table_name "empregados"
  set_primary_key :matricula
end

