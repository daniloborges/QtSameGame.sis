import QtQuick 1.0
import com.nokia.symbian 1.0
import com.nokia.extras 1.0
import "samegame.js" as SameGame

Page {
    id: pageGame
    tools: normal

    Item {
        id: gameCanvas
        property int score: 0
        property int blockSize: 40

        anchors.centerIn: parent
        width: parent.width - (parent.width % blockSize);
        height: parent.height - ((parent.height +6) % blockSize) + 6; //força 1 linha a mais
        enabled: false

        MouseArea {
            anchors.fill: parent
            onClicked: {
                SameGame.handleClick(mouse.x,mouse.y);
            }
        }
    }
    ListView{
        id: ranking
        anchors { fill: parent;}
        clip: true
        delegate:ListItem {
            id: listItem1
            Column {
                anchors.fill: listItem1.paddingItem
                ListItemText {
                    id: titleText
                    mode: listItem1.mode
                    role: "Title"
                    text: name
                }
                ListItemText {
                    id: subtitleText
                    mode: listItem1.mode
                    role: "SubTitle"
                    text: score + "pts - " + time +"s"
                }
            }
       }
       header:Component {
            id: listHeader
            ListHeading {
                id: listHeading
                ListItemText {
                    id: headingText
                    anchors.fill: listHeading.paddingItem
                    role: "Heading"
                    text: qsTr("Ranking")
                }
            }
        }
       model:SameGame.fillPlayersScore();
    }

    Component{
        id:dialogComponent

        WonDialog{
            id:wonDialog
            onNameChanged: if(name!="") SameGame.saveHighScore(name)
            onRejected: {
                notSavedBanner.open()
                SameGame.stopPlaying()
            }
            model: SameGame.fillPlayersName()
            InfoBanner {
                id: notSavedBanner

                text: qsTr("Score not saved")
                interactive: true
                timeout: 3000
                onClicked: SameGame.requestName(); //last chance to save score
            }
        }
    }

    ToolBarLayout{
        id:normal

        ToolButton{
            iconSource: "toolbar-back"
            onClicked: Qt.quit()
        }
        ToolButton{
            id: play
            text: qsTr("Play!")
            onClicked: SameGame.startNewGame()
        }
        //TODO: Erase ranking
        ToolButton{
            visible: false
            iconSource: "toolbar-menu"
            flat: true
        }
    }

    ToolBarLayout{
        id:playing

        ToolButton{
            iconSource: "toolbar-back"
            onClicked: SameGame.stopPlaying()
        }
        ToolButton{
            id: score
            text: gameCanvas.score +"pts"
            enabled: false
            flat: true
        }
        //Centralizar o score na horizontal, manter um botão escondido
        ToolButton{
            iconSource: "toolbar-menu"
            visible: false
        }
    }

    states: [
        State {
            name: "playing"
            PropertyChanges {
                target: gameCanvas
                enabled: true
            }
            PropertyChanges {
                target: ranking
                visible:false
            }
        }
    ]
    transitions: [
        Transition {
            to: ""
            ScriptAction{script:toolBar.setTools(normal, "replace")}
            PropertyAction { target: ranking; property: "visible"; value: true }
            NumberAnimation { target: ranking; property: "opacity"; easing.type: Easing.InCubic; to: 1; from: 0; duration: 300 }
        },
        Transition {
            to: "playing"
            ScriptAction{script:toolBar.setTools(playing, "replace")}
        }
    ]
}
