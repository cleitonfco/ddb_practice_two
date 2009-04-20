namespace :db do
  namespace :create do
    desc('Create mysql database.')
    task :mysql => :environment do
      puts("Creating MySql database...")
      system("rake RAILS_ENV=mysql db:create")
    end
  end
end

namespace :db do
  namespace :create do
    desc('Create postgres database.')
    task :postgres => :environment do
      puts("Creating Postgres database...")
      system("rake RAILS_ENV=postgres db:create")
    end
  end
end

namespace :db do
  namespace :migrate do
    desc('Migrate mysql databases.')
    task :mysql => :environment do
      config_file = File.join(RAILS_ROOT, "config/environments/mysql.rb")
      system ("touch #{config_file}") unless File.exists?(config_file)
      puts("Migrating MySql environment...")
      system("rake RAILS_ENV=mysql db:migrate:up VERSION=1")
    end
  end
end

namespace :db do
  namespace :migrate do
    desc('Migrate postgres databases.')
    task :postgres => :environment do
      config_file = File.join(RAILS_ROOT, "config/environments/postgres.rb")
      system ("touch #{config_file}") unless File.exists?(config_file)
      puts("Migrating Postgres environment...")
      system("rake RAILS_ENV=postgres db:migrate:up VERSION=2")
    end
  end
end

class Array
  def rand
    self[Kernel.rand(length)]
  end

  def shuffle
    self.sort_by{Kernel.rand}
  end
end

Masculinos = %w(Pedro Thiago Mateus Marcos Lucas Paulo Manoel Davi Rodrigo Raimundo Artur Elias Samuel Caio Cleiton Weldys Cyrus Charleno Luiz Felipe)
Femininos = %w(Maria Ana Teresa Luana Lucia Luciana Eline Alice Cecilia Bruna Elisangela Fabiana Katia Vania Janaina Juliana Viviane Dilma Marilene Paula)
Sobrenomes = %w(Silva Sousa Santos Almeida Gomes Vieira Pereira Mesquita Carvalho Rocha Cunha Pires Queiroz Cruz Lima Barros Alvarenga Lopes Braga Ramos)
Cidades = %w(Teresina Belem Fortaleza Natal Salvador Olinda Recife Vitoria Londrina Curitiba Timon Santos Campinas Brasilia Goiania Uberlandia Niteroi Caxias Blumenau Joinville)
Estados = %w(AC AL AP AM BA CE DF ES GO MA MT MS MG PA PB PR PE PI RJ RN RS RO RR SC SP SE TO)

def random_nome(genero)
  nome = (genero == "F" || genero == 2) ? Femininos.shuffle[0] : Masculinos.shuffle[0]
  s = Sobrenomes.shuffle
  sobrenome = "#{s[0]} #{s[1]}"
  "#{nome} #{sobrenome}"
end

def random_cep
  cep = (rand * 9999999).ceil + 60000000
  cep
end

def random_fone
  fone = (rand * 9999999).ceil + 50000000
  fone
end

namespace :db do
  namespace :populate do
    desc "Create 'Empregados' records in the mysql database."
    task :empregados => :environment do
      require 'lib/adapter_empregado'

      Empregado.delete_all
      100.times do |t|
        sexo = ["M", "F"].shuffle[0]
        endereco = "#{%w(Rua Av. Pça.).shuffle[0]} #{Sobrenomes.shuffle[0]}, #{(rand * 4999).ceil}" +
          " CEP #{random_cep.to_s.gsub(/(\d{5})(\d{3})/, "\\1-\\2")}",
        e = Empregado.new(
          :matricula => t + 1,
          :nome => random_nome(sexo),
          :cpf => (rand * 99999999).ceil + 58900000000,
          :salario => (rand * 599999).ceil * 0.01,
          :endereco => endereco,
          :cidade => Cidades.shuffle[0],
          :estado => Estados.shuffle[0],
          :fone_res => random_fone.to_s.gsub(/(\d{4})(\d{4})/, "\\1-\\2"),
          :fone_cel => random_fone.to_s.gsub(/(\d{4})(\d{4})/, "\\1-\\2"),
          :dia_nasc => (rand * 28).ceil,
          :mes_nasc => (rand * 12).ceil,
          :ano_nasc => (rand * 99).ceil + 1900,
          :sexo => sexo
        )
        e.save!
      end
    end
  end
end

namespace :db do
  namespace :populate do
    desc "Create 'Funcionarios' records in the postgres database."
    task :funcionarios => :environment do
      require 'lib/adapter_funcionario'

      Funcionario.delete_all
      100.times do |t|
        sexo = [1, 2].shuffle[0]
        nasc = Date.ordinal((rand * 90).ceil + 1900, (rand * 365).ceil)
        f = Funcionario.new(
          :identificacao => t + 1,
          :nome => random_nome(sexo),
          :cpf => ((rand * 99999999).ceil + 58900000000).to_s,
          :remuneracao => (rand * 599999).ceil * 0.01,
          :logradouro => "#{%w(Rua Av. Pça.).shuffle[0]} #{Sobrenomes.shuffle[0]}",
          :numero => (rand * 4999).ceil,
          :bairro => Masculinos.shuffle[0] + " " + Sobrenomes.shuffle[0],
          :cep => random_cep,
          :cidade => Cidades.shuffle[0],
          :estado => Estados.shuffle[0],
          :telefone => random_fone.to_s,
          :data_nasc => nasc,
          :sexo => sexo
        )
        f.save!
      end
    end
  end
end

namespace :db do
  namespace :populate do
    desc "Create 'Servidores' records in the XML file."
    task :servidores => :environment do
      xml = ""
      5.times do |t|
        xml << "<servidor arquivo=\"#{t + 1}\">\n"
        20.times do |u|
          sexo = ["M", "F"].shuffle[0]
          nasc = Date.ordinal((rand * 90).ceil + 1900, (rand * 365).ceil).to_s
          xml << "  <empregado>\n"
          xml << "    <registro>#{t * 20 + u + 1}</registro>\n"
          xml << "    <nome>#{random_nome(sexo)}</nome>\n"
          xml << "    <cpf>#{((rand * 99999999).ceil + 58900000000).to_s.gsub(/(\d{3})(\d{3})(\d{3})(\d{2})/, "\\1.\\2.\\3-\\4")}</cpf>\n"
          xml << "    <vencimento>#{(rand * 599999).ceil * 0.01}</vencimento>\n"
          xml << "    <logradouro>#{%w(Rua Av. Pça.).shuffle[0]} #{Sobrenomes.shuffle[0]}, #{(rand * 4999).ceil}</logradouro>\n"
          xml << "    <bairro>#{Masculinos.shuffle[0] + " " + Sobrenomes.shuffle[0]}</bairro>\n"
          xml << "    <cep>#{random_cep.to_s.gsub(/(\d{5})(\d{3})/, "\\1-\\2")}</cep>\n"
          xml << "    <cidade>#{Cidades.shuffle[0]}</cidade>\n"
          xml << "    <estado>#{Estados.shuffle[0]}</estado>\n"
          xml << "    <fone>#{random_fone.to_s.gsub(/(\d{4})(\d{4})/, "\\1-\\2")}</fone>\n"
          xml << "    <tipo_fone>#{["C", "R"].shuffle[0]}</tipo_fone>\n"
          xml << "    <nascimento>#{nasc}</nascimento>\n"
          xml << "    <sexo>#{(sexo == 'F') ? 'Feminino' : 'Masculino'}</sexo>\n"
          xml << "  </empregado>\n"
        end
        xml << "</servidor>\n"
        arquivo = File.join(RAILS_ROOT, "db/servidor_#{t + 1}.xml")
        File.open(arquivo, 'w') { |f| f.write(xml) }
        xml = ""
      end
    end
  end
end

