import QtQuick 1.0
import "samegame.js" as SameGame
import com.nokia.symbian 1.0


Window {
    id: window


    Image {
        id: background
        anchors { fill:parent; bottomMargin: toolBar.height }
        source: "qrc:/shared/pics/background.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    StatusBar{
        id: statusBar
        anchors {top: window.top; left: window.left; right: window.right }
    }

    PageStack{
        id:pageStack

        toolBar: toolBar
        anchors.fill: parent
    }

    ToolBar {
        id: toolBar

        anchors { bottom: window.bottom; left: window.left; right: window.right }
    }


    GamePage{
        id:gamePage

        anchors { fill:parent; bottomMargin: toolBar.height; topMargin: statusBar.height; }

        Component.onCompleted: pageStack.push(gamePage)
    }
}
