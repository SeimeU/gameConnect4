import QtQuick 2.0
import VPlay 2.0
import "../common"
import "../../../connect4"

SceneBase {
    id: gameScene

    // variable that indicates when a field on the pitch is pressed
    signal fieldButtonPressed(string selectedColumn)
    // variable that indicates when the game is over and someone won
    signal endScene
    // variable that indicates when the game is over and nobody won
    signal endSceneTied
    // the "name" of the active player is stored
    property string activePlayerName
    // the active player is stored
    property int player: 1
    // variables for the coordinates
    property int x_gameScene
    property int y_gameScene
    // loop variable
    property int c
    // variable to save how many stones already are in this column
    property int c1: 6
    property int c2: 6
    property int c3: 6
    property int c4: 6
    property int c5: 6
    property int c6: 6
    property int c7: 6


    // function to set the stones and change the player
    /*function setStone(player, selectedColumn){
        if(gameFunction.setStoneGame(player, selectedColumn))
        {
            if(gameFunction.won(player))
            {
                endScene()
            }
            if(gameFunction.tied())
            {
                endSceneTied()
            }

            // find the field and color it
            if(selectedColumn === "1")
            {
                c1: c1 - 1

                // x + c * 53 -> width = 50 and distance between = 3
                // y + c * 43 -> height = 40 and distance between = 3
                // y = 31,x = 53 -> left top corner
                x: 53
                y: (31 + c1 * 43)
            }
            if(selectedColumn === "2")
            {
                c2: c2 - 1

                x: (53 + 1 * 53)
                y: (31 + c2 * 43)
            }
            if(selectedColumn === "3")
            {
                c3: c3 - 1

                x: (53 + 2 * 53)
                y: (31 + c3 * 43)
            }
            if(selectedColumn === "4")
            {
                c4: c4 - 1

                x: (53 + 3 * 53)
                y: (31 + c4 * 43)
            }
            if(selectedColumn === "5")
            {
                c5: c5 - 1

                x: (53 + 4 * 53)
                y: (31 + c5 * 43)
            }
            if(selectedColumn === "6")
            {
                c6: c6 - 1

                x: (53 + 5 * 53)
                y: (31 + c6 * 43)
            }
            if(selectedColumn === "7")
            {
                c7: c7 - 1

                x: (53 + 6 * 53)
                y: (31 + c7 * 43)
            }

            Rectangle {
               id: fillRectangle
               width:  50
               height: 40

               // to round the edges
               radius: 10
            }

        // change active player
        if(player === 1)
        {
           state: "player2"
        }
        else
        {
           state: "player1"
        }
    }
}*/


    // player1 starts
   state: "player1"

   // background
    Rectangle{
        // the outside of the window -> changing its color to the player's color
        anchors.fill: parent.gameWindowAnchorItem
        color: "#324566"
    }

    // playing pitch
    Rectangle{
        id: playingPitch
        // middle of the window with the game field on it
        anchors.centerIn: parent
        width: 374      // 7 columns
        height: 258     // 6 rows
        color: "#324566"

        // creating the pitch
        Grid{
            anchors.centerIn: menuScene
            spacing: 3
            columns: 7

            FieldButton {
                onClicked: {
                   setStone(player, "1")
                }
            }

            FieldButton {
                onClicked: {
                   setStone(player, "2")
                }
            }

            FieldButton {
                onClicked: {
                   setStone(player, "3")
                }
            }

            FieldButton {
                onClicked: {
                   setStone(player, "4")
                }
            }

            FieldButton {
                onClicked: {
                   setStone(player, "5")
                }
            }

            FieldButton{
                onClicked: {
                    setStone(player, "6")
                }
            }

            FieldButton{
                onClicked: {
                    setStone(player, "7")
                }
            }

            // loop creating the fields
            Repeater{
                model: 35       // 7(columns) * (6 - 1)(rows)
                Rectangle {
                   width:  50
                   height: 40
                   color: "#e9e9e9"

                   // to round the edges
                   radius: 10
                }
            }
        }
    }

    // return button to return to the menu
    MenuButton{
        text: "back"

        // place him on the right top edge of the screen at any device
        anchors.right: gameScene.gameWindowAnchorItem.right
        anchors.rightMargin: 1
        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.topMargin: 1

        // when the button is pressed call the function backButtonPressed and clear the activePlayerName string
        onClicked: {
            backButtonPressed()
            activePlayerName = undefined
            activePlayerName = ""
        }
    }

    // name of the current player
    Text{
        id: playerText
        anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.topMargin: 5
        font.pixelSize: 20
        text: activePlayerName !== undefined ? activePlayerName : ""
    }

    // place a logo on the top left corner
    Image{
        source: "../../assets/vplay-logo.png"
        width: 50
        height: 50
        anchors.left: menuScene.gameWindowAnchorItem.left
        anchors.top: menuScene.gameWindowAnchorItem.top
    }

    // state machine -> to care about the changes when changing the player
    states: [
        State{
            name: "player1"
            PropertyChanges {target: playerColor; color: "red"}
            PropertyChanges {target: gameScene; activePlayerName: "Player1"}
            PropertyChanges {target: gameScene; player: "1"}
            PropertyChanges {target: playerText; color: "red"}
            PropertyChanges {target: fillRectangle; color: "red"}
        },
        State{
            name: "player2"
            PropertyChanges {target: playerColor; color: "yellow"}
            PropertyChanges {target: gameScene; activePlayerName: "Player2"}
            PropertyChanges {target: gameScene; player: "2"}
            PropertyChanges {target: playerText; color: "yellow"}
            PropertyChanges {target: fillRectangle; color: "yellow"}
        }
    ]
}
