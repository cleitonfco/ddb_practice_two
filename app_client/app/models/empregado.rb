class Empregado < ActiveRecord::Base
  establish_connection :mysql
  set_primary_key :matricula

  def chave
    read_matricula
  end

  def cpf
    read_cpf.to_s
  end

  def logradouro
    read_endereco
  end

  def numero; nil; end

  def bairro; nil; end

  def cep
    read_endereco.match(/CEP (\d{5}-?\d{3})/)[1]
  end

  def fone
    read_fone_res.gsub(/\D/, "")
  end

  def celular
    read_fone_cel.gsub(/\D/, "")
  end

  def nascimento
    "#{ano_nasc}-#{mes_nasc}-#{dia_nasc}".to_date if Date.valid_civil?(ano_nasc, mes_nasc, dia_nasc)
  end

  alias_method :id, :chave

  def self.map_select(select, origin, map)
    re = map.empty? ? Regexp.new("#{origin}\s*,?") : Regexp.new(origin)
    select.sub!(re, map) if select.include?(origin)
  end

  def self.conditions_hash(conditions)
    return nil if conditions.blank?

    mapping = {"id" => "matricula", "logradouro" => "endereco", "fone" => "fone_cel", "numero" => "", "bairro" => "", "celular" => "fone_cel"}

    conditions.each_pair do |key, value|
      if mapping.has_key?(key.to_s)
        conditions.merge!({ mapping[key.to_s].to_sym => value }) unless mapping[key.to_s].blank?
        conditions = conditions.delete_if { |k, v| k == key }
      end
    end
    if conditions.has_key?(:nascimento)
      case conditions[:nascimento]
        when Date; nascimento = conditions[:nascimento]
        when String
          begin; nascimento = conditions[:nascimento].to_date
          rescue; nascimento = nil
          end
      end
      conditions.merge!({ :ano_nasc => nascimento.year, :mes_nasc => nascimento.month, :dia_nasc => nascimento.day }) if nascimento.is_a? Date
      conditions = conditions.delete_if { |k, v| k == :nascimento }
    end
    #conditions
  end

  def self.replace_fields(statement, *values)
    statement.gsub!(/\b(id|logradouro|fone|celular)\b/) do
      case $1.strip
        when "id"; "matricula"
        when "logradouro"; "endereco"
        when "fone"; "fone_res"
        when "celular"; "fone_cel"
      end
    end
    statement.gsub!(/numero[^?]*\?/, "endereco like '%?%'")
    statement.gsub!(/bairro[^?]*\?/, "endereco like '%?%'")
    statement.gsub!(/cep[^?]*\?/, "endereco like '%?%'")
    match = /nascimento\s*=\s*\?/
    if statement =~ match
      nascimento = values.shift
      if values.empty? && nascimento.is_a?(Date)
        values.push(nascimento.year, nascimento.month, nascimento.day)
      end
      statement.sub!(match, "ano_nasc = ? AND mes_nasc = ? AND dia_nasc = ?")
    end
    values
  end

  def self.conditions_array(any)
    return nil if any.blank?
    any.first.gsub!(/\b(id|logradouro|fone|celular)\b/) do
      case $1.strip
        when "id"; "matricula"
        when "logradouro"; "endereco"
        when "fone"; "fone_res"
        when "celular"; "fone_cel"
      end
    end
    any.first.gsub!(/numero[^?]*\?/, "endereco like '%?%'")
    any.first.gsub!(/bairro[^?]*\?/, "endereco like '%?%'")
    any.first.gsub!(/cep[^?]*\?/, "endereco like '%?%'")

    copy = any.dup
    whatever = copy.shift

    match = /nascimento\s*=\s*\?/
    if any.first =~ match
      amd = "ano_nasc = ? AND mes_nasc = ? AND dia_nasc = ?"
      if copy.size == 1
        nascimento = any.second
        if nascimento.is_a?(Date)
          any = amd, nascimento.year, nascimento.month, nascimento.day
        end
      end
    end
  end

  def self.find(*args)
    options = args.extract_options!
    mapping = {"id" => "matricula", "logradouro" => "endereco", "cep" => "endereco", "fone" => "fone_res", "numero" => "",
      "bairro" => "", "celular" => "fone_cel", "nascimento" => "dia_nasc, mes_nasc, ano_nasc"}
    if options[:select]
      mapping.each_pair { |key, value| map_select(options[:select], key, value) }
    end
    case options[:conditions]
      when Hash; conditions_hash(options[:conditions])
      when Array; options[:conditions] = conditions_array(options[:conditions])
      #else
    end
    super(args.first, options)
  end

  def method_missing(method, *args)
    respond_to?(method) ? super : read_attribute(method.to_s.sub(/^read_/, ""))
  end
end


#class AdapterEmpregado

#  def initialize
#    @map_fields = {
#      "id" => "matricula",
#      "logradouro" => "endereco",
#      "fone" => "fone_res",
#      "celular" => "fone_cel"
#    }
#  end

#  def select(*args)
#    result = []
#    Empregado.find(args).each do |e|
#      result << e.to_json
#    end
#    result
#  end

#  def map_conditions(condition)
#    return nil if condition.blank?

#    case condition
#      when Array; map_array_for_conditions(condition)
#      when String; map_string_for_conditions(condition)
#      else condition
#    end
#  end

#  def map_array_for_conditions(condition)
#    @map_fields.each do |key, value|
#      condition.first.gsub!(/#{key}/, value)
#    end
#    if condition.first.include?("numero")
#    end
#    if condition.first.include?("bairro")
#    end
#    if condition.first.include?("cep")
#    end
#    if condition.first.include?("nascimento")
#    end
#    if condition.first.include?("sexo")
#    end
#  end

#  def ano_nasc
#
#  end

#  def map_string_for_conditions(condition)
#  end

#        # Accepts an array of conditions. The array has each value
#        # sanitized and interpolated into the SQL statement.
#        # ["name='%s' and group_id='%s'", "foo'bar", 4] returns "name='foo''bar' and group_id='4'"
#        def sanitize_sql_array(ary)
#          statement, *values = ary
#          if values.first.is_a?(Hash) and statement =~ /:\w+/
#            replace_named_bind_variables(statement, values.first)
#          elsif statement.include?('?')
#            replace_bind_variables(statement, values)
#          else
#            statement % values.collect { |value| connection.quote_string(value.to_s) }
#          end
#        end
#end

