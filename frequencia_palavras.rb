class AnalisadorLinha
    attr_accessor :numero_linha,:conteudo_linha
    def initialize (numero_linha,conteudo_linha)
        @numero_linha = numero_linha
        @conteudo_linha=conteudo_linha
        @palavra_frequente=Array.new{}
    end
    
    def contador_palavras()
        words_map = Hash.new {0}
        @conteudo_linha.each { |palavra|
          if words_map.has_key? palavra
            words_map[palavra] += 1
          else
            words_map[palavra] = 1
          end
        }
      
        return words_map
    end
    
    def adicionar_palavra_frequente(hash)
        big = 0
        hash.each { |key, value|
          if (value >= big)
            @palavra_frequente.push(key)
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
        o = ordenar_hash(hash)
        adicionar_palavra_frequente(o)

    def to_str
        return "Palavra(s) mais frequente(s): #{@palavra_frequente} da linha #{@numero_linha}"
    end
end

f = File.read("texto.txt")
linhas = f.split("\n")
linhas.each_index {|index|
    linha = linhas[index]
    palavras = linha.split(" ")
    ob = AnalisadorLinha.new(index+1,palavras)
    ob.contar()
    puts ob.to_str   
}
end



