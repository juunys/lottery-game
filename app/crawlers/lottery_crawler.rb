require 'open3'
require 'fileutils'
require 'roo'

class LotteryCrawler
  LOTTERY_URL = "https://asloterias.com.br/download_excel.php"
  LOTTERY_FILENAME = "lotofacil_results.xlsx"
  HEADERS = [
    "Content-Type: application/x-www-form-urlencoded",
    "Origin: https://asloterias.com.br",
    "Referer: https://asloterias.com.br/download-todos-resultados-lotofacil",
    "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"
  ]
  POST_DATA = 'l=lf&t=t&o=s&f1=&f2='

  # Método para buscar o arquivo e extrair resultados
  def self.fetch_lotofacil_results
    file_path = Rails.root.join('tmp', LOTTERY_FILENAME)
    ensure_directory_exists(file_path)

    # Comando curl para baixar o arquivo
    curl_command = build_curl_command(file_path)

    puts "Baixando arquivo..."
    stdout, stderr, status = Open3.capture3(*curl_command)

    if status.success? && valid_file?(file_path)
      puts "Arquivo baixado com sucesso em: #{file_path}"
      game_type = GameType.find_by(code: "lotofacil")
      process_xlsx(file_path, game_type)
    else
      puts "Erro ao baixar o arquivo: #{stderr}"
    end
  end

  # Verifica se o diretório de destino existe, caso contrário, cria
  def self.ensure_directory_exists(file_path)
    FileUtils.mkdir_p(File.dirname(file_path))
  end

  # Cria o comando curl para download
  def self.build_curl_command(file_path)
    [
      "curl", "-X", "POST", LOTTERY_URL,
      *HEADERS.map { |header| ["-H", header] }.flatten,
      "--data-raw", POST_DATA,
      "-o", file_path.to_s
    ]
  end

  # Verifica se o arquivo baixado é válido
  def self.valid_file?(file_path)
    File.exist?(file_path) && File.size(file_path) > 0
  end

  # Método para processar o arquivo .xlsx
  def self.process_xlsx(filename, game_type)
    puts "\nExtraindo dados..."
    xlsx = Roo::Excelx.new(filename)
    results = []

    xlsx.default_sheet = xlsx.sheets.first # Seleciona a primeira planilha
    xlsx.each_row_streaming(offset: 5) do |row|
      # Verifica se a linha não está em branco
      draw = row[0]&.value
      draw_date = row[1]&.value
      next unless draw.present? && draw_date.present?

      # Extrai os números sorteados
      numbers = row[2..game_type.max_number - 1].map(&:value)
      results << { numbers: numbers, draw_date: draw_date, draw: draw }
    end

    results
  end
end