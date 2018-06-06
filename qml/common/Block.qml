import VPlay 2.0
import QtQuick 2.0

EntityBase {
  id: block
  entityType: "block"

  // hide block if outside of game area
  visible: y >= 31

  // each block knows its type and its position on the field
  property int type
  property int row
  property int column

  // show different colored rectangles for block types
  Rectangle {
      width:  50
      height: 40
      border.color: "black"
      border.width: 5
      // to round the edges
      radius: 10
      color: {
          if(type == 1){
              return "red"
          }
          else if(type == 2){
              return "yellow"
          }
          else{
              return "#e9e9e9"
          }
      }
  }
}
