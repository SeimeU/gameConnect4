import QtQuick 2.0
import VPlay 2.0
import "../common"

SceneBase{
    id: endScene

    // background
    Rectangle{
        anchors.fill: parent.gameWindowAnchorItem
        color: "#324566"
    }

    // exit button to end the programm
    MenuButton{
        text: "Exit"

        // place him on the right top edge of the screen at any device
        anchors.right: parent.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: parent.gameWindowAnchorItem.top
        anchors.topMargin: 10
        // close the program
        onClicked:  close()

    }

    // the "logo"
    Text {
          // headline positioned on the top center of the screen at any resolution without borders
          text: {
              if(gameScene.Player == 1){
                    return "The winner is Player" + 2
              }
              else{
                  return "The winner is Player" + 1
              }
          }
          font.pixelSize: 30
          color: "#e9e9e9"
          anchors.horizontalCenter: parent.gameWindowAnchorItem.horizontalCenter
          y: 30
    }

    // place image in the middle of the screen
    Image{
        // source -> https://psvaduz.wordpress.com/2012/09/17/gewonnen/
        source: "../../assets/pokal.gif"
        width: 100
        height: 140
        anchors.centerIn: endScene
    }

    // place a logo on the top left corner
    Image{
        source: "../../assets/vplay-logo.png"
        width: 50
        height: 50
        anchors.left: parent.gameWindowAnchorItem.left
        anchors.top: parent.gameWindowAnchorItem.top
    }
}
