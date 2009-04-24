class AdapterFuncionario

  def initialize
  end

  def select(*args)
    result = []
    #:all, :conditions => "identificacao <= 10"
    Funcionario.find(args).each do |f|
      result << f.to_json
    end
    result
  end
end

class Funcionario < ActiveRecord::Base
  establish_connection :postgres
  set_primary_key :identificacao
end

