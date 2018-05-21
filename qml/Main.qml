import VPlay 2.0
import QtQuick 2.0
import "scenes"

GameWindow {
    id: window

    screenWidth: 960
    screenHeight: 640

    // menu scene
    MenuScene{
        id: menuScene

        // look at the button signal in the menu and change the windowstate if the buttons is pressed
        onStartGamePressed: window.state = "game"
    }

    // scene where the actual game is played
    GameScene{
        id: gameScene

        // get to end scene won
        onEndScene: window.state = "endWon"
        //get to end scene tied
        onEndSceneTied: window.state = "endTied"
    }

    // end scene -> won
    EndScene{
        id: endScene
    }

    // end scene -> tied
    EndSceneTied{
        id: endSceneTied

        // return to the menu scene
        onBackButtonPressed: window.state = "menu"
    }

    // first active scene is menu when you start the application
    state: "menu"
    activeScene: menuScene

    // state machine -> to care about the changes when shifting the state
    states: [
        State{
            name: "menu"
            PropertyChanges {target: menuScene; opacity: 1}
            PropertyChanges {target: window; activeScene: menuScene}
        },
        State{
            name: "game"
            PropertyChanges {target: gameScene; opacity: 1}
            PropertyChanges {target: window; activeScene: gameScene}
        },
        State{
            name: "endWon"
            PropertyChanges {target: endScene; opacity: 1}
            PropertyChanges {target: window; activeScene: endScene}
        },
        State{
            name: "endTied"
            PropertyChanges {target: endSceneTied; opacity: 1}
            PropertyChanges {target: window; activeScene: endSceneTied}
        }
    ]
}
