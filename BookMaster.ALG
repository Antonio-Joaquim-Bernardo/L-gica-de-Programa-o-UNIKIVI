Algoritmo "SISTEMA DE GESTÃO DE BIBLIOTÉCAS - BOOKMASTER v1.0"
// Disciplina  : Lógica de Programação II
// Docente      : Moyo Kanivengidio
// Descrição    : Gestão de Livros com controle de empréstimos e remoção.
// Programadores: 1.	ANTÓNIO JOAQUIM BERNARDO; 2.	IGRAÇA NZINGA S. KIAWETE;
// 3. JOÃO ISAÍAS TRUVÃO; 4.	MARIA TUSSONGUA BENEDITH; 5.	NELSA NZAGE JOÃO;
// Data atual  : 06/04/2026
//__________________________________________________________________________________________________________________________________________________

// =================================================================================================================================================
// SEÇÃO DOS REGISTROS
// =================================================================================================================================================

tipo livro = registro
   codigo, ano: inteiro
   titulo, autor, disponivel : caracter
   // Campos para controle de leitores
   nomeLeitor, moradaLeitor, telefoneLeitor: caracter
fimregistro

Var
   // =================================================================================================================================================
   // SEÇÃO DE DECLARAÇÕES DE VARIÁVEIS GLOBAIS
   // =================================================================================================================================================

   livros: vetor[1..100] de livro
   auxLivro: livro
   user, userCorreto, senha, senhaCorreta, buscar, confirma: caracter
   tentativas, tentativasMax, codigoBusca, codigoNovo: inteiro
   livrosDispo, livrosEmpre, totalLivros, i, j, op, subOp: inteiro
   codigoExiste, pesquisou, encontrou, enter: logico

   // =================================================================================================================================================
   // SEÇÃO DE DECLARAÇÕES DAS FUNÇÕES E PROCEDIMENTOS
   // =================================================================================================================================================

funcao codigoJaExiste(cod: inteiro): logico
// Função responsável por verificar o código do livro a ser cadastrado
var
   i: inteiro
   encontrou: logico
inicio
   encontrou <- falso
   para i de 1 ate totalLivros faca
      se livros[i].codigo = cod entao
         encontrou <- verdadeiro
      fimse
   fimpara
   retorne encontrou
fimfuncao

funcao procurarLivro(cod: inteiro): inteiro
// Função responsável por procurar livros no vetor
var
   i: inteiro
   posicaoEncontrada: inteiro
inicio
   posicaoEncontrada <- 0
   para i de 1 ate totalLivros faca
      se livros[i].codigo = cod entao
         posicaoEncontrada <- i
      fimse
   fimpara
   retorne posicaoEncontrada
fimfuncao

procedimento exibirBoasVindas()
// Procedimento responsável por exibir uma saudação ao usuário
inicio
   limpatela
   escreval(" _________________________________________________________________________________________________________________")
   escreval("|                                                                                                                 |")
   escreval("|                                             BEM VINDO AO BOOKMASTER                                             |")
   escreval("|                                                  Versão 1.0                                                     |")
   escreval("|_________________________________________________________________________________________________________________|")
   escreval("|                                                                                                                 |")
   escreval("|  O BookMaster é um sistema completo para gestão de acervos literários, desenvolvido para facilitar              |")
   escreval("|  o controle de cadastros, empréstimos, devoluções e relatórios estatísticos de bibliotecas.                     |")
   escreval("|                                                                                                                 |")
   escreval("|  EQUIPE DE DESENVOLVIMENTO:                                                                                     |")
   escreval("|  1. ANTÓNIO JOAQUIM BERNARDO                                                                                    |")
   escreval("|  2. IGRAÇA NZINGA DE SOUSA KIAWETE                                                                              |")
   escreval("|  3. JOÃO ISAÍAS TRUVÃO                                                                                          |")
   escreval("|  4. MARIA TUSSONGUA BENEDITH                                                                                    |")
   escreval("|  5. NELSA NZAGE JOÃO                                                                                            |")
   escreval("|_________________________________________________________________________________________________________________|")
   escreval("")
   escreva("| >> Pressione 'Enter' para iniciar o sistema...")
   leia(enter)
fimprocedimento

procedimento exibirMenu()
// Procedimento responsável por exibir o menu Inicial
inicio
   limpatela
   escreval(" _________________________________________________________________________________________________________________")
   escreval("|                                           MENU DO BOOKMASTER                                                    |")
   escreval("| 1-Cadastrar | 2-Listar | 3-Pesquisar | 4-Emprestar | 5-Devolver | 6-Ordenar | 7-Eliminar | 8-Relatório | 0-Sair |")
   escreval("|_________________________________________________________________________________________________________________|")
   escreva("| Opção: ")
fimprocedimento

procedimento listarLivros(filtro: inteiro)
// Procedimento responsável por listar os livros cadastrados com opções de: 1-Todos, 2-Emprestados, 3-Disponíveis
inicio
   escreval("|_________________________________________________________________________________________________________________")
   escreval("| CÓDIGO     | TÍTULO                                     | AUTOR                          |   ANO   | DISPONÍVEL |")
   para i de 1 ate totalLivros faca
      se (filtro = 1) ou ((filtro = 2) e (livros[i].disponivel = "Não")) ou ((filtro = 3) e (livros[i].disponivel = "Sim")) entao
         escreval("| ", livros[i].codigo:10, " | ", livros[i].titulo:42, " | ", livros[i].autor:30, " | ", livros[i].ano:7, " | ", livros[i].disponivel:10, " |")
         se (livros[i].disponivel = "Não") e (filtro <> 3) entao
            escreval("| > Emprestado para: ", livros[i].nomeLeitor, " (Tel: ", livros[i].telefoneLeitor, ")", "(Mor: )", livros[i].moradaLeitor)
         fimse
      fimse
   fimpara
fimprocedimento

procedimento exibirLivroEncontrado()
// Procedimento resposável por exibir um livro pequisado
inicio
   escreval(" _________________________________________________________________________________________________________________")
   escreval("|                                              [Livro Encontrado]                                                 |")
   escreval("|-----------------------------------------------------------------------------------------------------------------|")
   escreval("| CÓDIGO     | TÍTULO                                     | AUTOR                          |   ANO   | DISPONÍVEL |")
   escreval("| ", livros[i].codigo:10, " | ", livros[i].titulo:42, " | ", livros[i].autor:30, " | ", livros[i].ano:7, " | ", livros[i].disponivel:10, " |")
   se (livros[i].disponivel = "Não") entao
      escreval("| > Emprestado para: ", livros[i].nomeLeitor, " (Tel: ", livros[i].telefoneLeitor, ")", "(Mor: )", livros[i].moradaLeitor)
   fimse
fimprocedimento

procedimento ordenarPorTitulo()
// Procedimento responsável por ordenar por Título a lista dos livros cadastrados
inicio
   se totalLivros > 1 entao
      para i de 1 ate totalLivros - 1 faca
         para j de i + 1 ate totalLivros faca
            se livros[i].titulo > livros[j].titulo entao
               auxLivro <- livros[i]
               livros[i] <- livros[j]
               livros[j] <- auxLivro
            fimse
         fimpara
      fimpara
      listarLivros(1)
   senao
      escreval("| Quantidade de livros insuficiente para ordenar. |")
   fimse
   escreval("| Enter para continuar")
   leia(enter)
fimprocedimento

procedimento ordenarPorAutor()
// Procedimento responsável por ordenar por Autor a lista dos livros cadastrados
inicio
   se totalLivros > 1 entao
      para i de 1 ate totalLivros - 1 faca
         para j de i + 1 ate totalLivros faca
            se livros[i].autor > livros[j].autor entao
               auxLivro <- livros[i]
               livros[i] <- livros[j]
               livros[j] <- auxLivro
            fimse
         fimpara
      fimpara
      listarLivros(1)
   senao
      escreval("| Quantidade de livros insuficiente para ordenar. |")
   fimse
   escreval("| Enter para continuar")
   leia(enter)
fimprocedimento

Inicio
   // =================================================================================================================================================
   // CORPO PRINCIPAL DO SISTEMA
   // =================================================================================================================================================

   totalLivros <- 0
   userCorreto <- "BookMaster"
   senhaCorreta <- "bookmaster2026"
   tentativas <- 0
   tentativasMax <- 3

   exibirBoasVindas() // procedimento de boas vindas

   enquanto (tentativas < tentativasMax) faca
      // Autenticação do sistema
      limpatela
      escreval(" _________________________________________________________________________________________________________________")
      escreval("|                                                 TELA DE LOGIN                                                   |")
      escreval("|_________________________________________________________________________________________________________________|")
      escreval("| Digite o seu usuário: ")
      escreva("|R: ")
      leia(user)
      escreval("| Digite a sua senha: ")
      escreva("|R: ")
      leia(senha)

      se (user = userCorreto) e (senha = senhaCorreta) entao
         escreval("|_________________________________________________________________________________________________________________")
         escreval("|                                                                                                                 |")
         escreval("|                                                   OLÁ, ", user:30, "                           |")
         escreval("|_________________________________________________________________________________________________________________|")
         escreva("| >> Pressione 'Enter' para continaur...")
         leia(enter)

         repita
            exibirMenu() // Menu Principal
            leia(op)
            escolha(op)
            caso 0
               // O CASO 0, Simplesmente limpa para sair do laço
               limpatela

            caso 1
               // Bloco responsável por Cadastrar os livros
               limpatela
               escreval(" _________________________________________________________________________________________________________________")
               escreval("|                                          BOOKMASTER - CADASTRAR                                                 |")
               escreval("|_________________________________________________________________________________________________________________|")
               se totalLivros < 100 entao
                  escreval("| Digite o código do Livro: ")
                  escreva("|R: ")
                  leia(codigoNovo)
                  codigoExiste <- codigoJaExiste(codigoNovo)
                  // Verificação do código do livro para saber se o mesmo já foi utilizado no sistema
                  enquanto codigoExiste faca
                     escreval("| Código já existe! Digite outro: ")
                     escreva("|R: ")
                     leia(codigoNovo)
                     codigoExiste <- codigoJaExiste(codigoNovo)
                  fimenquanto
                  // Se o código ainda não foi utilizado o programa contina por aqui
                  totalLivros <- totalLivros + 1
                  livros[totalLivros].codigo <- codigoNovo
                  escreval("| Digite o título do Livro: ")
                  escreva("|R: ")
                  leia(livros[totalLivros].titulo)
                  escreval("| Digite o autor do Livro: ")
                  escreva("|R: ")
                  leia(livros[totalLivros].autor)
                  escreval("| Digite o ano de Lançamento: ")
                  escreva("|R: ")
                  leia(livros[totalLivros].ano)
                  livros[totalLivros].disponivel <- "Sim"
                  escreval("| Livro Cadastrado com Sucesso! Enter para continuar")
                  leia(enter)
               senao
                  escreval("| Limite atingido! Enter para voltar")
                  leia(enter)
               fimse

            caso 2
               // Bloco responsável por Listar todos os livros do sistema com filtros
               repita
                  limpatela
                  escreval(" _________________________________________________________________________________________________________________")
                  escreval("|                                        BOOKMASTER - LISTA DOS LIVROS                                            |")
                  escreval("|                        1- Todos  |  2- Emprestados  |  3- Disponíveis  |  0- Voltar                             |")
                  escreval("|_________________________________________________________________________________________________________________|")
                  escreva("| Opção: ")
                  leia(subOp)
                  se (subOp <> 0) entao
                     se (totalLivros = 0) entao
                        escreval("| Nenhum livro cadastrado!")

                     senao
                        listarLivros(subOp)
                     fimse
                     escreval("|-----------------------------------------------------------------------------------------------------------------|")
                     escreval("| Enter para continuar")
                     leia(enter)
                  fimse
               ate subOp = 0

            caso 3
               // Bloco responsável por Pesquisar livros (Código, Título ou Autor)
               repita
                  limpatela
                  escreval(" _________________________________________________________________________________________________________________")
                  escreval("|                                             BOOKMASTER - PESQUISAR                                              |")
                  escreval("|                                     1-Código | 2-Título ou Autor | 0-Voltar                                     |")
                  escreval("|_________________________________________________________________________________________________________________|")
                  se (totalLivros = 0) entao
                     escreval("| Nenhum livro cadastrado!")
                     leia(enter)
                     subOp <- 0
                  senao
                     escreva("| Opção: ")
                     leia(subOp)
                     encontrou <- falso
                     escolha subOp
                     caso 1
                        // Pesquisa por Código
                        escreva("| Código: ")
                        leia(codigoBusca)
                        para i de 1 ate totalLivros faca
                           se livros[i].codigo = codigoBusca entao
                              encontrou <- verdadeiro
                              exibirLivroEncontrado() // Procedimento para exibir um livro
                           fimse
                        fimpara
                     caso 2
                        // Pesquisa por Título ou Autor
                        escreva("| Título ou Autor: ")
                        leia(buscar)
                        para i de 1 ate totalLivros faca
                           se (livros[i].titulo = buscar) ou (livros[i].autor = buscar) entao
                              encontrou <- verdadeiro
                              exibirLivroEncontrado() // Procedimento para exibir um livro
                           fimse
                        fimpara
                     fimescolha
                     se (subOp <> 0) entao
                        se nao encontrou entao
                           escreval("| Nenhum resultado encontrado!")
                        fimse
                        escreval("|_________________________________________________________________________________________________________________|")
                        escreval("|     Enter para continuar     ")
                        leia(enter)
                     fimse
                  fimse
               ate subOp = 0

            caso 4
               // Bloco responsável por Emprestar livros, usuando todas as informações do procedimento criado em cima
               limpatela
               escreval(" _________________________________________________________________________________________________________________")
               escreval("|                                          BOOKMASTER - EMPRESTAR LIVRO                                           |")
               escreval("|_________________________________________________________________________________________________________________|")
               escreval("| Código do livro: ")
               escreva("|R: ")
               leia(codigoBusca)
               encontrou <- falso
               i <- procurarLivro(codigoBusca)
               se i <> 0 entao
                  encontrou <- verdadeiro
                  se livros[i].disponivel = "Sim" entao
                     escreval("| Livro: ", livros[i].titulo)
                     escreval("| Digite o Nome do Leitor: ")
                     escreva("|R: ")
                     leia(livros[i].nomeLeitor)
                     escreval("| Digite o Telefone: ")
                     escreva("|R: ")
                     leia(livros[i].telefoneLeitor)
                     escreval("| Digite a Morada: ")
                     escreva("|R: ")
                     leia(livros[i].moradaLeitor)
                     livros[i].disponivel <- "Não"
                     escreval("| Empréstimo realizado com sucesso!")
                  senao
                     escreval("| Erro: Este livro já está emprestado!")
                  fimse
               fimse
               se nao encontrou entao
                  escreval("| Erro: Código não encontrado!")
               fimse
               escreval("|     Enter para continuar")
               leia(enter)

            caso 5
               // Bloco responsável por Devolver livros; só se ele foi emprestado
               limpatela
               escreval(" _________________________________________________________________________________________________________________")
               escreval("|                                           BOOKMASTER - DEVOLVER LIVRO                                           |")
               escreval("|_________________________________________________________________________________________________________________|")
               escreval("| Código do livro: ")
               escreva("|R: ")
               leia(codigoBusca)
               encontrou <- falso
               i <- procurarLivro(codigoBusca)
               se i <> 0 entao
                  encontrou <- verdadeiro
                  se livros[i].disponivel = "Não" entao
                     livros[i].disponivel <- "Sim"
                     livros[i].nomeLeitor <- ""
                     livros[i].telefoneLeitor <- ""
                     livros[i].moradaLeitor <- ""
                     escreval("| Devolução concluída! Dados do leitor removidos.")
                  senao
                     escreval("| Aviso: Este livro já está disponível!")
                  fimse
               fimse
               se nao encontrou entao
                  escreval("| Erro: Código não encontrado!")
               fimse
               escreval("|     Enter para continuar")
               leia(enter)

            caso 6
               // Bloco responsável por Ordenar a lista de livros, com filtros (Título e Autor)
               repita
                  limpatela
                  escreval(" _________________________________________________________________________________________________________________")
                  escreval("|                                           BOOKMASTER - ORDENAR LIVROS                                           |")
                  escreval("|                                          1-Título | 2-Autor | 0-Voltar                                          |")
                  escreval("|_________________________________________________________________________________________________________________|")
                  escreva("| Opção: ")
                  leia(subOp)
                  escolha subOp
                  caso 1
                     // Ordenar livros por título, usando o procedimento ordenarPorTitulo criado acima
                     ordenarPorTitulo()
                  caso 2
                     // Ordenar livros por autor, usando o procedimento ordenarPorAutorr criado acima
                     ordenarPorAutor()
                  fimescolha
               ate subOp = 0

            caso 7
               // Bloco responsável por Eliminar um livro, se existir, usando a verificação do código e a confirmação S/N
               limpatela
               escreval(" _________________________________________________________________________________________________________________")
               escreval("|                                             BOOKMASTER - ELIMINAR                                               |")
               escreval("|_________________________________________________________________________________________________________________|")
               escreval("| Código do livro para eliminar: ")
               escreva("|R: ")
               leia(codigoBusca)
               encontrou <- falso

               i <- procurarLivro(codigoBusca)
               se i <> 0 entao
                  encontrou <- verdadeiro
                  escreval("| LIVRO: ", livros[i].titulo)
                  escreval("| AUTOR: ", livros[i].autor)
                  escreval("| Deseja realmente eliminar este livro? (S/N): ")
                  escreva("|R: ")
                  leia(confirma)

                  se (confirma = "S") ou (confirma = "s") entao
                     // Puxa todos os livros seguintes uma posição para trás
                     para j de i ate totalLivros - 1 faca
                        livros[j] <- livros[j+1]
                     fimpara
                     totalLivros <- totalLivros - 1
                     escreval("| Livro eliminado com sucesso!")
                  senao
                     escreval("| Operação cancelada.")
                  fimse
               senao
                  escreval("| Erro: Livro não encontrado!")
               fimse
               escreval("|  Enter para voltar  |")
               leia(enter)

            caso 8
               // Bloco responsável por Gerar um pequeno relatório
               limpatela
               escreval(" _________________________________________________________________________________________________________________")
               escreval("|                                          BOOKMASTER - RELATÓRIO GERAL                                           |")
               escreval("|_________________________________________________________________________________________________________________|")
               livrosDispo <- 0
               livrosEmpre <- 0
               para i de 1 ate totalLivros faca
                  se livros[i].disponivel = "Sim" entao
                     livrosDispo <- livrosDispo + 1
                  senao
                     livrosEmpre <- livrosEmpre + 1
                  fimse
               fimpara
               escreval("| Livros Cadastrados: ", totalLivros)
               escreval("| Livros Emprestados: ", livrosEmpre)
               escreval("| Livros Disponíveis: ", livrosDispo)
               escreval("|-------------------------|")
               escreval("|   Enter para voltar     |")
               leia(enter)

            outrocaso
               se (op <> 0) entao
                  escreval("| Opção inválida Enter para continuar |")
                  leia(enter)
               fimse
               limpatela
            fimescolha
         ate (op = 0)
         // Mensagem de saída
         limpatela
         escreval(" _________________________________________________________________________________________________________________")
         escreval("|                                                                                                                 |")
         escreval("|                                       OBRIGADO POR USAR O BOOKMASTER!                                           |")
         escreval("|                                            Até logo, ", user:30, "                             |")
         escreval("|_________________________________________________________________________________________________________________|")
         // Para encerrar o loop forçamos o fim com as tentativas
         tentativas <- tentativasMax
      senao
         // Bloco de erro de autenticação
         tentativas <- tentativas + 1
         se tentativas < tentativasMax entao
            escreval("| Credenciais inválidas! Tentativas restantes: ", tentativasMax - tentativas, " Enter para continuar")
            leia(enter)
         senao
            escreval(" _________________________________________________")
            escreval("|    SISTEMA BLOQUEADO por excesso de tentativas! |")
            escreval(" -------------------------------------------------")
            leia(enter)
         fimse
      fimse
   fimenquanto

Fimalgoritmo
