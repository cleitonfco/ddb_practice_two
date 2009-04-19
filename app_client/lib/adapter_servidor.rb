require 'nokogiri'
require 'json'

class AdapterServidor
  def initialize
    @doc = Nokogiri::XML(open(File.join(File.dirname(__FILE__), 'servidor.xml')))
  end

end

class Servidor
  attr_accessor :registro, :nome, :cpf, :vencimento, :logradouro, :bairro, :cep
  attr_accessor :cidade, :estado, :fone, :tipo_fone, :nascimento, :sexo

  def map(node)
    @registro = ''
    @nome = ''
    @cpf = ''
    @vencimento = ''
    @logradouro = ''
    @bairro = ''
    @cep = ''
    @cidade = ''
    @estado = ''
    @fone = ''
    @tipo_fone = ''
    @nascimento = ''
    @sexo
  end
end

