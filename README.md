# Vó Neuza no Apocalipse (IMCOMPLETO)

**Vó Neuza no Apocalipse** é um jogo de narrativa interativa para iOS, desenvolvido em 7 dias utilizando SwiftUI e outras ferramentas posteriormente descritas. O jogo segue a Vó Neuza, uma avó destemida, em sua jornada para salvar seus netinhos durante um apocalipse zumbi.

## 🌟 Funcionalidades

📢 **Narrativa Interativa:** Os jogadores tomam decisões que afetam o curso da história da Vó Neuza.

🗣️ **Diálogos e Escolhas:** A história é contada através de diálogos entre personagens, com opções de escolha que levam a diferentes cenas e resultados.

✍️ **Animações e Efeitos Visuais:** Elementos de interface como balões de fala, transições de cena e animações de personagens para uma experiência mais envolvente.

🔊 **Efeitos Sonoros:** Efeitos de som para diálogos (som de zumbi, som de escolha) e música de fundo para enriquecer a atmosfera do jogo.

💰 **Sistema de Recompensas:** O jogador pode obter "recompensas" visuais ao longo da jornada.

👀 **Gerenciamento de Estado:** O jogo utiliza `AppStorage` para salvar o progresso, permitindo que os jogadores "continuem o jogo" a partir do último ponto de verificação.

📽️ **Cenas de Cutscene:** Uma cena de introdução em vídeo para dar início à história.


## 📁 Estrutura do Projeto

O projeto é organizado em várias Views do SwiftUI, cada uma responsável por uma parte específica do jogo.

* `InicialMenu.swift`: A tela inicial do jogo, onde o jogador pode começar um novo jogo ou continuar um jogo salvo.
* `InicialScene.swift`: Lida com a reprodução da cena de introdução em vídeo antes do início do jogo.
* `FinalScene.swift`: A tela final do jogo, que exibe o resultado da jornada da Vó Neuza e a recompensa obtida.
* `FinalDialog.swift`: Gerencia a cena de diálogo final, incluindo a interação com os netos e a conclusão da história.
* `FarmacChoice.swift`: Lida com a cena de escolha relacionada aos remédios de Vó Neuza.
* `TheirdDialog.swift`: Uma cena de diálogo que leva a uma escolha de recompensa.
* `ChoiceThree.swift`: Gerencia a cena de escolha da recompensa (cookies ou pão).
* `DataModel.swift`: Contém as estruturas de dados principais (`DialogueLine`, `Choice`, `GameScene`) e o dicionário de cenas (`ScenesDictionary`) que define toda a narrativa do jogo.
* `ChoiceButtonView.swift`: Um componente de botão reutilizável para as escolhas do jogador, com um efeito sonoro ao ser pressionado.
* `LogicState.swift`: Uma classe simples para gerenciar o estado do jogo e a transição entre cenas com base nas escolhas do jogador.
<img width="2871" height="1392" alt="image 1" src="https://github.com/user-attachments/assets/107a170c-cf71-4996-b9cc-5c81a749b864" />

## 🛠️ Como Funciona o Jogo

O fluxo principal do jogo é baseado na navegação entre as `GameScene`s definidas no `DataModel.swift`. Cada `GameScene` possui:

* Um `id` único.
* Uma lista de `dialogues` (diálogos).
* Uma lista de `choices` (opções de escolha), que direcionam o jogador para a próxima cena.

O jogo usa `State` e `AppStorage` para gerenciar a cena atual e o progresso do jogador. Quando o jogador interage com a tela, o diálogo avança. Ao final dos diálogos de uma cena, as opções de escolha aparecem (se houver). A seleção de uma escolha atualiza o estado do jogo e carrega a próxima cena.

## 🤝 CREDITOS / AGRADECIMENTOS
