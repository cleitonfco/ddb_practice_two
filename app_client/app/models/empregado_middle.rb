#require 'lib/adapter_empregado'
#require 'lib/adapter_funcionario'
#require 'lib/adapter_servidor'
class EmpregadoMiddle

  attr_reader :id, :nome, :cpf, :salario, :logradouro, :numero, :bairro, :cep, :cidade, :estado, :fone, :celular, :nascimento, :sexo

  def initialize
#    @empregado = AdapterEmpregado.new
#    @funcionario = AdapterFuncionario.new
  end

  def all
    find :all
  end

  def find(options)
    rows = []
    Empregado.find(:all, :conditions => "id <= 10").each { |row| rows << row }
    Funcionario.find(:all, :conditions => "id <= 10").each { |row| rows << row }
#    AdapterServidor.select(options).each { |row| rows << row }
    rows
  end

end


#:id
#:logradouro
#:numero
#:bairro
#:cep
#:cidade
#:estado
#:fone
#:celular
#:nascimento
#:sexo

#"id @ :id, nascimento > :nasc, salario = :valor, celular <> :cel, fone = :f, cep = :cpe"
#.sub(/id([^:]*):(\w+)/, "matricula\\1:\\2")
#.sub(/logradouro([^:]*):(\w+)/, "endereco\\1:\\2")
#.sub(/numero([^:]*):(\w+)\s*,?/, "")
#.sub(/bairro([^:]*):(\w+)\s*,?/, "")
#.sub(/fone([^:]*):(\w+)/, "fone_res\\1:\\2")
#.sub(/celular([^:]*):(\w+)/, "fone_cel\\1:\\2")
#.sub(/cep\s*=\s*:(\w+)/, "endereco like '%:\\1%'")
#.sub(/nascimento([^:]*):(\w+)/, "dia_nasc\\1:\\2")



#a = "11/8/1968"
#b = "15/10/1969"
#c = "3/12/1975"

#a <= b
#(aa < ab) || (aa <= ab && ma < mb) || (aa <= ab && ma <= mb && da <= db)

#a < b
#(aa < ab) || (aa == ab && ma < mb) || (aa == ab && ma == mb && da < db)

#a >= b
#(aa > ab) || (aa >= ab && ma > mb) || (aa >= ab && ma >= mb && da >= db)

#a > b
#(aa > ab) || (aa == ab && ma > mb) || (aa == ab && ma == mb && da > db)

#a == b
#(aa == ab && ma == mb && da == db)

#a <> b
#(aa <> ab || ma <> mb || da <> db)

