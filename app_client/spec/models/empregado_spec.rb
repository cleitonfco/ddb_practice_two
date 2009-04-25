require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Empregado do

  it "mapeia ID para MATRICULA" do
    statement = "id > ? and salario < ?"
    emp = Empregado.replace_fields(statement)
    statement.should == "matricula > ? and salario < ?"
  end

  it "mapeia LOGRADOURO para ENDERECO" do
    statement = "logradouro = ? and salario < ?"
    emp = Empregado.replace_fields(statement)
    statement.should == "endereco = ? and salario < ?"
  end

  it "mapeia FONE para FONE_RES" do
    statement = "fone = ?"
    emp = Empregado.replace_fields(statement)
    statement.should == "fone_res = ?"
  end

  it "mapeia CELULAR para FONE_CEL" do
    statement = "celular = ?"
    emp = Empregado.replace_fields(statement)
    statement.should == "fone_cel = ?"
  end

  it "mapeia NUMERO para ENDERECO (com Like)" do
    statement = "numero = ? and salario < ?"
    emp = Empregado.replace_fields(statement)
    statement.should == "endereco like '%?%' and salario < ?"
  end

  it "mapeia BAIRRO para ENDERECO (com like)" do
    statement = "bairro = ? and salario < ?"
    emp = Empregado.replace_fields(statement)
    statement.should == "endereco like '%?%' and salario < ?"
  end

  it "mapeia CEP para ENDERECO (com like)" do
    statement = "cep = ? and salario < ?"
    emp = Empregado.replace_fields(statement)
    statement.should == "endereco like '%?%' and salario < ?"
  end

#  it "mapeia NASCIMENTO para DIA_NASC, MES_NASC, ANO_NASC" do
#    statement = "nascimento = ?"
#    values = Date.today - ((rand * 30).ceil.day)
#    nasc = values.dup
#    emp = Empregado.replace_fields(statement, values)
#    statement.should == "ano_nasc = ? AND mes_nasc = ? AND dia_nasc = ?"
#    values.should == [nasc.year, nasc.month, nasc.day]
#  end

  it "mapeia NASCIMENTO para DIA_NASC, MES_NASC, ANO_NASC #2" do
    statement = "nascimento = ?"
    values = Date.today - ((rand * 30).ceil.day)
    nasc = values.dup
    emp = Empregado.replace_fields(statement, values)
    statement.should == "ano_nasc = ? AND mes_nasc = ? AND dia_nasc = ?"
    values.should == [nasc.year, nasc.month, nasc.day]
  end


#  it "substitui os valores de nasc pelos de DIA_NASC, MES_NASC, ANO_NASC" do
#    statement = "nasc = ? and sexo = ?"
#    emp = Empregado.replace_values(statement, values)
#    emp.should == "ano_nasc = #{} AND mes_nasc = ? AND dia_nasc = ?"
#  end



end
