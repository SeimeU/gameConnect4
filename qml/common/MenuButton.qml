import QtQuick 2.0

// button for the menu and the back button
Rectangle {
   id: menuButton

   // the button has the size of the text plus our constants
   width:  buttonText.width+ widthTemp
   height: buttonText.height+ heightTemp
   color: "green"

   // to round the edges
   radius: 10

   property int widthTemp: 20
   property int heightTemp: 10

   // to access to the text from the Text component
   property alias text: buttonText.text

   // called when the button is clicked
   signal clicked

   Text{
      id: buttonText
      anchors.centerIn: parent
      font.pixelSize: 18
      color: "black"
   }

   MouseArea{
       id: mouseArea
       anchors.fill: parent
       onClicked: menuButton.clicked()
       onPressed: menuButton.opacity = 0.5
       onReleased: menuButton.opacity = 1
   }
}
