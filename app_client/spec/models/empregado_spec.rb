require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Empregado do

  it "Mapeia ID para MATRICULA" do
    statement = "id > ? and salario < ?"
    emp = Empregado.replace_fields(statement, [15, 3000])
    statement.should == "matricula > ? and salario < ?"
  end

  it "Mapeia LOGRADOURO para ENDERECO" do
    statement = "logradouro = ? and salario < ?"
    emp = Empregado.replace_fields(statement, ['algo', 3000])
    statement.should == "endereco = ? and salario < ?"
  end

  it "Mapeia FONE para FONE_RES" do
    statement = "fone = ?"
    emp = Empregado.replace_fields(statement, "5555-4955")
    statement.should == "fone_res = ?"
  end

  it "Mapeia CELULAR para FONE_CEL" do
    statement = "celular = ?"
    emp = Empregado.replace_fields(statement, "9555-4955")
    statement.should == "fone_cel = ?"
  end

  it "Mapeia NUMERO para ENDERECO (com Like)" do
    statement = "numero = ? and salario < ?"
    emp = Empregado.replace_fields(statement, [15, 3000])
    statement.should == "endereco like '%?%' and salario < ?"
  end

  it "Mapeia BAIRRO para ENDERECO (com like)" do
    statement = "bairro = ? and salario < ?"
    emp = Empregado.replace_fields(statement, ['algo', 3000])
    statement.should == "endereco like '%?%' and salario < ?"
  end

  it "Mapeia CEP para ENDERECO (com like)" do
    statement = "cep = ? and salario < ?"
    emp = Empregado.replace_fields(statement, [15000880, 3000])
    statement.should == "endereco like '%?%' and salario < ?"
  end

end
