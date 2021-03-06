class Palavra
  attr_accessor :palavra, :frequencia

  def initialize(palavra, frequencia)
    @palavra = palavra
    @frequencia = frequencia
  end
end

class AnalisadorLinha
    attr_accessor :numero_linha, :conteudo_linha, :palavra_frequente
    def initialize (numero_linha, conteudo_linha)
        @numero_linha = numero_linha
        @conteudo_linha=conteudo_linha
        @palavra_frequente=Array.new{}
    end
    
    def contador_palavras()
        palavras_hash = Hash.new {0}
        @conteudo_linha.each { |palavra|
          if palavras_hash.has_key? palavra
            palavras_hash[palavra] += 1
          else
            palavras_hash[palavra] = 1
          end
        }
      
        return palavras_hash
    end
    
    def adicionar_palavra_frequente(hash)
        big = 0
        hash.each { |key, value|
          if value >= big
            palavra = Palavra.new(key, value)
            @palavra_frequente.push(palavra)
            big = value
          else
            break
          end
        }
    end

    def ordenar_hash(hash)
        return Hash[hash.sort_by {|k, v| -v}]
    end

    def contar()
        hash = contador_palavras()
        hash_ordenado = ordenar_hash(hash)
        adicionar_palavra_frequente(hash_ordenado)
    end

    def to_str
        return "Palavra(s) mais frequente(s): #{@palavra_frequente} da linha #{@numero_linha}"
    end
end

f = File.read("texto.txt")
analisador_arr = Array.new{0}
linhas = f.split("\n")
linhas.each_with_index {|linha, index|
    palavras = linha.split(" ")
    ob = AnalisadorLinha.new(index+1,palavras)
    ob.contar()
    analisador_arr.push(ob)
}

analisador_arr.each { |item|
  item.palavra_frequente.each { |palavra|
    puts "Palavra: #{palavra.palavra}\nFrequencia: #{palavra.frequencia}\nLinha: #{item.numero_linha}"
    puts "================="
  }
}
