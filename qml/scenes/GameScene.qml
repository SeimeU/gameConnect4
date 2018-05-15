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
    // variable to save how many stones already are in this column
    property variant c
    c: [6, 6, 6, 6, 6, 6]

    // fixed values
    property int fixX: 53
    property int fixY: 31
    property int addX: 53
    property int addY: 43

    // "constants" for the size of the pitch
    property int cColumn:  7
    property int cRows: 6

    // creating a pitch
    property variant pitch
    pitch: [cRows * cColumn]


    // function to set the stones and change the player
    function setStone(player, selectedColumn){

        var row;
        var column = selectedColumn;

        if(setStoneGame(player, selectedColumn, row))
        {
            if(won(player, row, column))
            {
                endScene()
            }
            if(tied())
            {
                endSceneTied()
            }

            // find the field and color it
            if(selectedColumn === "1")
            {
                c[0] = c[0] - 1

                // x + c * 53 -> width = 50 and distance between = 3
                // y + c * 43 -> height = 40 and distance between = 3
                // y = 31,x = 53 -> left top corner
                x: fixX
                y: (fixY + c[0] * addY)
            }
            if(selectedColumn === "2")
            {
                c[1] = c[1] - 1

                x: (fixX + 1 * addX)
                y: (fixY + c[1] * addY)
            }
            if(selectedColumn === "3")
            {
                c[2] = c[2] - 1

                x: (fixX + 2 * addX)
                y: (fixY + c[2] * addY)
            }
            if(selectedColumn === "4")
            {
                c[3] = c[3] - 1

                x: (fixX + 3 * addX)
                y: (fixY + c[3] * addY)
            }
            if(selectedColumn === "5")
            {
                c[4] = c[4] - 1

                x: (fixX + 4 * addX)
                y: (fixY + c[4] * addY)
            }
            if(selectedColumn === "6")
            {
                c[5] = c[5] - 1

                x: (fixX + 5 * addX)
                y: (fixY + c[5] * addY)
            }
            if(selectedColumn === "7")
            {
                c[6] = c[6] - 1

                x: (fixX + 6 * addX)
                y: (fixY + c[6] * addY)
            }

            /*Rectangle {
               id: fillRectangle
               width: 50
               height: 40

               // to round the edges
               radius: 10
            }*/

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
}

function setStoneGame(player, selectedColumn, row){

    var col;
    var r;

    // my two "constants"
    var ROWS = cRows;
    var COLUMNS = cColumn;

    // there is no multidimensional arrays in JavaScript so create my own one
    var field = new Array();


    for(r = 0; r < ROWS;r++){
        for(col = 0;col < ROWS;col++){
            field[r] = new Array();
            field[r][col] = pitch[r * COLUMNS + col];
        }
    }

    for(r = ROWS - 1;r >= 0;r++){
         // "set" the stone in the array
         if(field[r][col] === 0)
         {
              // found a free field
              pitch[r * COLUMNS + col] = player;
              row = r;

              return true;
          }
   }

   return true;

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

    // there is no multidimensional arrays in JavaScript so create my own one
    var field = new Array();


    for(r = 0; r < ROWS;r++){
        for(col = 0;col < ROWS;col++){
            field[r] = new Array();
            field[r][col] = pitch[r * COLUMNS + col];
        }
    }

    // check the pross
    for(c = 0, counter = 0;c < COLUMNS;c++){

        if(field[row][c] === player){
            counter++;

            if(counter === 4) {

                return true;
            }
        }
        else
        {
            counter = 0;
        }
    }

    // check the vertical
    for(r = ROWS - 1, counter = 0;r >= 0;r--){
        if(field[r][column] === player){
            counter++;

            if(counter === 4){
                return true;
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
                return true;
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
                return true;
            }
        }
        else{
            counter = 0;
        }
    }

    return false;
}

function tied(){
    var c;
    var col;
    var r;

    // there is no multidimensional arrays in JavaScript so create my own one
    var field = new Array();


    for(r = 0; r < ROWS;r++){
        for(col = 0;col < ROWS;col++){
            field[r] = new Array();
            field[r][col] = pitch[r * COLUMNS + col];
        }
    }


    for(c = 0;c < COLUMNS;c++){
        if(field[0][c] === 0){
           return false;
        }
    }

    return true;
}

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

            // loop creating the buttons
            Repeater{
                model: 7
                FieldButton{
                    onClicked: {
                        setStone(player, model)
                    }
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
            PropertyChanges {target: gameScene; activePlayerName: "Player1"}
            PropertyChanges {target: gameScene; player: "1"}
            PropertyChanges {target: playerText; color: "red"}
            PropertyChanges {target: fillRectangle; color: "red"}
        },
        State{
            name: "player2"
            PropertyChanges {target: gameScene; activePlayerName: "Player2"}
            PropertyChanges {target: gameScene; player: "2"}
            PropertyChanges {target: playerText; color: "yellow"}
            PropertyChanges {target: fillRectangle; color: "yellow"}
        }
    ]
}
