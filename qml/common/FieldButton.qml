import QtQuick 2.0
import VPlay 2.0

// button for the fields on the pitch in the game scene
Rectangle {
   id: fieldButton

   width:  50
   height: 40
   color: "#e9e9e9"

   // to round the edges
   radius: 10

   // called when the button is clicked
   signal clicked

   MouseArea{
       id: mouseArea
       anchors.fill: parent
       onClicked: {
           fieldButton.clicked()
       }
   }
}
