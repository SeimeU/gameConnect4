import QtQuick 2.0
import VPlay 2.0
import "../common"

SceneBase{
    id: endSceneTied

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
          text: "Tied!"
          font.pixelSize: 40
          color: "#e9e9e9"
          anchors.horizontalCenter: parent.gameWindowAnchorItem.horizontalCenter
          y: 30
    }

    // place image in the middle of the screen
    Image{
        // source -> https://www.wettbasis.com/strategien/rome.php
        source: "../../assets/rome.gif"
        width: 100
        height: 140
        anchors.centerIn: endSceneTied
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
