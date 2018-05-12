import QtQuick 2.0
import VPlay 2.0
import "../common"      //.. to move one ordner backwards

SceneBase {
     id: menuScene

     // variable that indicates when the button to start the game is pressed
     signal startGamePressed
     // variable that indicates when the button to end the programm is pressed
     signal endProgrammPressed

     // background
     Rectangle{
         anchors.fill: parent.gameWindowAnchorItem
         color: "#324566"
     }

     // the "logo"
     Text {
           // headline positioned on the top center of the screen at any resolution without borders
           text: "Connect 4"
           font.pixelSize: 30
           color: "#e9e9e9"
           anchors.horizontalCenter: menuScene.gameWindowAnchorItem.horizontalCenter
           y: 30
     }

     // make two buttons displayed in the middle of the screen among themselves
     Column{
         anchors.centerIn: parent
         spacing: 10

         // start button to start the game
         MenuButton{
            text: "Start"
            // start the game
            onClicked:  startGamePressed()
         }

         // exit button to end the programm
         MenuButton{
             text: "Exit "
             // close the program
             onClicked:  close()

         }
     }

     // place a logo on the top left corner
     Image{
         source: "../../assets/vplay-logo.png"
         width: 50
         height: 50
         anchors.left: menuScene.gameWindowAnchorItem.left
         anchors.top: menuScene.gameWindowAnchorItem.top
     }
}
