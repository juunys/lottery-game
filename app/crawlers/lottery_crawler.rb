require 'open3'
require 'fileutils'

class LotteryCrawler
  # Método para buscar o arquivo e extrair resultados
  def self.fetch_lotofacil_results
    url = "https://asloterias.com.br/download_excel.php"
    filename = "lotofacil_results.xlsx"
    file_path = Rails.root.join('tmp', filename) 
    
    # Garantir que o diretório 'tmp' existe
    FileUtils.mkdir_p(File.dirname(file_path))

    # Definir os headers e dados POST conforme o cURL fornecido
    headers = [
      "Content-Type: application/x-www-form-urlencoded",
      "Origin: https://asloterias.com.br",
      "Referer: https://asloterias.com.br/download-todos-resultados-lotofacil",
      "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"
    ]

     # Definir dados POST (l=lf&t=t&o=s&f1=&f2=)
    post_data = 'l=lf&t=t&o=s&f1=&f2='

    # Comando curl
    curl_command = [
      "curl", "-X", "POST", url,
      *headers.map { |header| ["-H", header] }.flatten,
      "--data-raw", post_data,
      "-o", file_path.to_s  # Salvar o arquivo na pasta tmp
    ]

    puts "Baixando arquivo..."
    puts ""

    # Executar o comando curl
    stdout, stderr, status = Open3.capture3(*curl_command)

    if status.success? && File.exist?(file_path) && File.size(file_path) > 0
      puts "Arquivo baixado com sucesso em: #{file_path}"
      game_type = GameType.find_by(code: "lotofacil")
      process_xlsx(file_path, game_type)
    else
      puts "Erro ao baixar o arquivo: #{stderr}"
    end

  end

  # Método para processar o arquivo .xlsx
  def self.process_xlsx(filename, game_type)
    puts ""
    puts "extraindo..."
    puts ""
    # Abrir o arquivo usando a gema Roo
    xlsx = Roo::Excelx.new(filename)

    results = []

    # Pular as 6 primeiras linhas e ir para a linha 7 (onde começa o cabeçalho)
    xlsx.default_sheet = xlsx.sheets.first # Seleciona a primeira planilha
  	first_row_logged = false 
    xlsx.each_row_streaming(offset: 5) do |row|
      	# Verifica se a linha não está em branco
      	# A data do sorteio estará na segunda coluna e o concurso na primeira
      	draw = row[0]&.value
      	draw_date = row[1]&.value

      	next unless draw.present? && draw_date.present?

      	# Extrair os números sorteados (de "bola 1" até o máximo definido no game type)
      	numbers = row[2..game_type.max_number - 1].map(&:value)

    	# Armazenando o sorteio no array de resultados
      	results << { numbers: numbers, draw_date: draw_date, draw: draw }
    end
    results
  end
end

class LotteryGameSeeder
  def self.seed_lotofacil_games
    # Buscando os resultados do arquivo baixado
    results = LotteryCrawler.fetch_lotofacil_results

    # Salvando os resultados no banco de dados
    results.each do |result|
      # Garantir que o GameType para "lotofacil" existe
      game_type = GameType.find_by(code: "lotofacil")
      
      if game_type
        # Salvando o sorteio
        DrawnGame.create!(
          game_type_id: game_type.id,
          numbers: result[:numbers],
          draw_date: Date.parse(result[:draw_date]),
          draw: result[:draw]
        )
      end
    end
  end
end
