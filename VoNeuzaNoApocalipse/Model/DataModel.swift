//
//  Scene.swift
//  VoNeuzaNoApocalipse
//
//  Created by Thayssa Romão on 31/07/25.
//
struct DialogueLine {
    let speaker: String
    let text: String
    let triggersZombieSound: Bool

}

struct Choice {
    let textButton: String
    let destinationId: String
}

struct GameScene {
    let id: String
    let dialogues: [DialogueLine]
    let choices: [Choice]
}

let ScenesDictionary: [String: GameScene] = [
    "FirstDialog": GameScene(
        id: "firstDialog",
        dialogues: [
            DialogueLine(speaker: "vovo", text: "APOCALIPSE MEU FII !!",triggersZombieSound: false),
            DialogueLine(speaker: "vovo", text: "Meus três netinhos precisam de mim", triggersZombieSound: false),
            DialogueLine(speaker: "vovo", text: "Será que da tempo de fazer um bolin?",triggersZombieSound: false)
        ],
        choices: []
    ),
    
    "Initial": GameScene(
        id: "initial",
        dialogues: [
            DialogueLine(speaker: "vovo", text: "Meus netinhos são tudo pra mim!",triggersZombieSound: false)
        ],
        choices: [
            Choice(textButton: "Salvar Netinhos", destinationId: "SecondDialog"),
            Choice(textButton: "Tirar Cochilo", destinationId: "Não Salvar Netos")
        ]
    ),
    
    "SecondDialog": GameScene(
        id: "secondDialog",
        dialogues: [
            DialogueLine(speaker: "vovo", text: "AVE LOLA",triggersZombieSound: false),
            DialogueLine(speaker: "vovo", text: "Aqueles zumbis não são o perigo",triggersZombieSound: false),
            DialogueLine(speaker: "vovo", text: "O real perigo é chegar atrasada para o nosso almoço de domingo",triggersZombieSound: false),
            DialogueLine(speaker: "vovo", text: "Vou puxar o carin pra chegar logo",triggersZombieSound: false)
        ],
        choices: []
    ),
    
    "FirstZombie": GameScene(
        id: "firstZombie",
        dialogues: [
            DialogueLine(speaker: "zumbi", text: "ARGHHH",triggersZombieSound: true),
            DialogueLine(speaker: "vovo", text: "Que isso fio",triggersZombieSound: false),
            DialogueLine(speaker: "zumbi", text: "Grrrraaaaah",triggersZombieSound: true),
            DialogueLine(speaker: "zumbi", text: "CEREBROOOOOOOO",triggersZombieSound: true),
            DialogueLine(speaker: "vovo", text: "tanta coisa boa para fazer meu fi",triggersZombieSound: false),
            DialogueLine(speaker: "vovo", text: "Vai ser feliz meu bem tomar um sol",triggersZombieSound: false),
            DialogueLine(speaker: "zumbi", text: "Você tem toda a razão vovó",triggersZombieSound: true),
            DialogueLine(speaker: "zumbi", text: "Agora sou livre pra fazer o que quiser",triggersZombieSound: true),
            DialogueLine(speaker: "zumbi", text:"obrigada Vovó *beijinho💋*",triggersZombieSound: true)],
           
        choices: [
            Choice(textButton: "Fofocar com morto", destinationId: "Papear"),
            Choice(textButton: "EU SOU MAIS VELHA ME RESPEITA", destinationId: "Brigar com morto")
        ]
    ),
    
    "Farmacol": GameScene(
        id:"farmacol",
        dialogues: [
            DialogueLine(speaker: "vovo", text: "Ahhh diacho",triggersZombieSound: false),
            DialogueLine(speaker: "vovo", text: "Esqueci o remédio de diabetes",triggersZombieSound: false),
            DialogueLine(speaker: "vovo", text: "Não posso ficar sem o remédio",triggersZombieSound: false),
        ],
        choices: [
            Choice(textButton: "Passar na Farmácia", destinationId: "Tem remedio"),
            Choice(textButton: "Ir direto pros netinhos", destinationId: "sem remedio")

            
        ]
    ),
    "TheirdDialog": GameScene(
        id: "theirdDialog",
        dialogues: [
            DialogueLine(speaker: "vovo", text: "Agora com o remédio, eu sou invencícel",triggersZombieSound: false),
            DialogueLine(speaker: "vovo", text: "Vou passar na padaria e comprar um lanchinho",triggersZombieSound: false),
            DialogueLine(speaker: "vovo", text: "Certeza que os meninos vão adorar",triggersZombieSound: false),
            DialogueLine(speaker: "vovo", text: "Amo meus netinhos",triggersZombieSound: false)
        ],
        choices: []
    ),
    "SecondZombie": GameScene(
        id: "secondZombie",
        dialogues: [
            DialogueLine(speaker: "zumbi", text: "ARGHHH",triggersZombieSound: true),
            DialogueLine(speaker: "vovo", text: "SEU ANTONIO ATE VOCÊ",triggersZombieSound: false),
            DialogueLine(speaker: "zumbi", text: "Mua-RHHgh",triggersZombieSound: true),
           DialogueLine(speaker: "vovo", text: "Preciso urgente de uma lanchinho",triggersZombieSound: false),
           DialogueLine(speaker: "vovo", text: "Meus Netos estão me esperando",triggersZombieSound: false),
            DialogueLine(speaker: "zumbi", text:"VovoGhrg  Pode escolher uma lanchinho RHHRRRrr",triggersZombieSound: true)],
        
           
        choices: [
            Choice(textButton: "Cookies", destinationId: "Cookie"),
            Choice(textButton: "Pãozinho", destinationId: "Pão")
        ]
    ),
    "FourthDialog": GameScene(
        id: "fourthDialog",
        dialogues: [
            DialogueLine(speaker: "vovo", text: "TÔ CHEGANDO NETINHOS",triggersZombieSound: false)
        
        ],
        choices: []
    ),
    "FinalDialog": GameScene(
        id: "finalDialog",
        dialogues: [
            DialogueLine(speaker: "vovo", text: "Meninos !!",triggersZombieSound: false),
            DialogueLine(speaker: "crianças", text: "Vovó você chegou !", triggersZombieSound: false),
            DialogueLine(speaker: "vovo", text: "Comprei um negocinho, passei na farmácia e dei lição de moral em dois zumbis!", triggersZombieSound: false),
                    DialogueLine(speaker: "crianças", text: "Você é a melhor vovó do mundo!", triggersZombieSound: false),
                    DialogueLine(speaker: "vovo", text: "Agora senta todo mundo! Vai ter cafézinho e história de guerra zumbi!", triggersZombieSound: false),
                    DialogueLine(speaker: "zumbi", text: "Tem lugar pra mais um?", triggersZombieSound: true),
                    DialogueLine(speaker: "vovo", text: "Claro, mas lava essa mão podre antes!", triggersZombieSound: false),
        ],
        choices: []
    ),
    "FinalScene": GameScene(
        id: "finalScene",
        dialogues: [
            DialogueLine(speaker: "vovo", text: "Vamos comer e esperar o fim do mundo",triggersZombieSound: false),
            DialogueLine(speaker: "vovo", text: "Seus Pais vão dar um jeito em tudo",triggersZombieSound: false)

        ],
        choices: []
    )
    
]
