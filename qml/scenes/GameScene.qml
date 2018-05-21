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
    property int player
    // variables for the coordinates
    property variant x_gameScene: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    property variant y_gameScene: [80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80]

    // fixed values
    property int fixX: 53
    property int fixY: 31
    property int addX: 53
    property int addY: 43

    // "constants" for the size of the pitch
    property int cColumn:  7
    property int cRows: 6

    // creating a pitch
    property variant pitch : [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

    // function to set the stones and change the player
    function setStone(player, selectedColumn){

        var row = setStoneGame(player, selectedColumn);

        if(row){
                // x + c * 53 -> width = 50 and distance between = 3
                // y + c * 43 -> height = 40 and distance between = 3
                // y = 31,x = 53 -> left top corner
                gameScene.x_gameScene= (fixX + selectedColumn * addX);
                gameScene.y_gameScene= (fixY + row * addY);

                won(player, row, selectedColumn)

                tied();

                changePlayer(player);
        }
    }

    function changePlayer(player){

        // change active player
        if(player === 1){
           gameScene.state= "player2"
        }
        else{
          gameScene.state=  "player1"
        }
    }

function setStoneGame(player, selectedColumn){
    var col;
    var r;

    // my two "constants"
    var ROWS = cRows;
    var COLUMNS = cColumn;

    // multidimensional array
    var field = [[0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0]];

    for(r = 0; r < ROWS;r++){
        for(col = 0;col < COLUMNS;col++){
           field[r][col] = pitch[r * COLUMNS + col];
        }
    }

    for(r = ROWS - 1, col = selectedColumn;r >= 0;r--){
        // "set" the stone in the array
        if(field[r][col] === 0){
           // found a free field
           pitch[r * COLUMNS + col] = player;
           // return the active row
           return r;
        }
     }

     return -1;
}

function won(player, row, column){
    var r;
    var c;
    var col;
    // counts the occurence of the active player in a row
    var counter;

    // my two "constants"
    var ROWS = cRows;
    var COLUMNS = cColumn;

    // multidimensional array
    var field = [[0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0]];

    for(r = 0; r < ROWS;r++){
       for(col = 0;col < ROWS;col++){  
            field[r][col] = pitch[r * COLUMNS + col];
       }
    }

    // check the pross
    for(c = 0, counter = 0;c < COLUMNS;c++){

        if(field[row][c] === player){
            counter++;

            if(counter === 4) {
                endScene();
            }
        }
        else{
           counter = 0;
        }
     }

     // check the vertical
     for(r = ROWS - 1, counter = 0;r >= 0;r--){
        if(field[r][column] === player){
           counter++;

           if(counter === 4){
                endScene();
           }
         }
         else{
            counter = 0;
         }
     }

     // check the leading diagonal
     for(c = column, r = row;c > 0 && r > 0;c--, r--);

     for(counter = 0; c < COLUMNS && r < ROWS;c++, r++){
         if(field[r][c] === player){
             counter++;

             if(counter === 4){
                endScene();
             }
         }
         else{
             counter = 0;
         }
     }

     // check the minor diagonal
     for(c = column, r = row;c < COLUMNS - 1 && r > 0;c++, r--);

     for(counter = 0; c >= 0 && r < ROWS;c--, r++){
         if(pitch[r][c] === player){
             counter++;

             if(counter === 4){
                 endScene();
              }
         }
         else{
             counter = 0;
         }
   }
}

function tied(){
    var c;
    var col;
    var r;
    var ROWS = cRows;
    var COLUMNS = cColumn;

    // multidimensional array
    var field = [[0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0]];

    for(r = 0; r < ROWS;r++){
       for(col = 0;col < ROWS;col++){
            field[r][col] = pitch[r * COLUMNS + col];
       }
    }

    for(c = 0;c < COLUMNS;c++){
        if(field[0][c] === 0){
           return;
        }
    }

    endSceneTied();
}
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

            // loop creating the fields
            Repeater{
                model: 42       // 7(columns) * (6 - 1)(rows)
                Rectangle {
                   width:  50
                   height: 40
                   color: "#e9e9e9"

                   border.color: "black"
                   border.width: 5

                   // to round the edges
                   radius: 10
                }
            }

            Repeater{
                model: 7
                FieldButton{
                    onClicked:{
                        setStone(player, index)
                    }
                }
            }
        }
    }

    // return button to return to the menu
    MenuButton{
        text: "exit"

        // place him on the right top edge of the screen at any device
        anchors.right: gameScene.gameWindowAnchorItem.right
        anchors.rightMargin: 1
        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.topMargin: 1

        // when the button is pressed call the function backButtonPressed and clear the activePlayerName string
        onClicked: close()
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

    Rectangle {
        id: fillRectangle
        width:  50
        height: 40
        border.color: "black"
        border.width: 5
        // to round the edges
        radius: 10
        x: x_gameScene
        y: y_gameScene
    }

    // player1 starts
   state: "player1"

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
            PropertyChanges {target: gameScene; activePlayerName: "Player1"}
            PropertyChanges {target: gameScene; player: 1}
            PropertyChanges {target: playerText; color: "red"}
            PropertyChanges {target: fillRectangle; color: "red"}
        },
        State{
            name: "player2"
            PropertyChanges {target: gameScene; activePlayerName: "Player2"}
            PropertyChanges {target: gameScene; player: 2}
            PropertyChanges {target: playerText; color: "yellow"}
            PropertyChanges {target: fillRectangle; color: "yellow"}
        }
    ]
}
