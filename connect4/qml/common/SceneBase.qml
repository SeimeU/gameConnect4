import QtQuick 2.0
import VPlay 2.0

Scene {
    id: sceneBase

    // set the opacity to 0 -> so that it is not visble
    opacity: 0

    // improve performance -> when opacity is 0 visible is false -> so it is invisible and the renderer skips it
    visible: opacity > 0

    // to disable the scene when it is invisible
    enabled: visible

    // when the opacity is changed it will happen with an animation
    Behavior on opacity {
        NumberAnimation {property: "opacity"; easing.type: Easing.InOutQuad}
    }
}
