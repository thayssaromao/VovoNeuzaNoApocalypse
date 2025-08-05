//
//  LogicState.swift
//  VoNeuzaNoApocalipse
//
//  Created by Thayssa Romão on 31/07/25.
//

//MARK: Managing the current game state


class LogicState {    
    private var scenes: [String: GameScene]
    private(set) var currentScene: GameScene
    
    init(scenes: [String : GameScene], idInitialScene: String) {
        self.scenes = scenes
        guard let startScene = scenes[idInitialScene] else {
            fatalError("Cena com ID \(idInitialScene) não encontrada.")
        }
        self.currentScene = startScene
    }
    
    func makeChoice(choice: Choice){
        
        if let nextScene = scenes[choice.destinationId]{
            self.currentScene = nextScene
        }else{
            print("Cena com ID \(choice.destinationId) não encontrado")
        }
        
        
    }
}
