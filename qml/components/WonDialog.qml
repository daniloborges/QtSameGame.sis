import QtQuick 1.0
import com.nokia.symbian 1.0


SelectionDialog {
    property string name
    property string defaultTitle: "pts! ...But who?"

    id: nameSelection

    //titleText: score + defaultTitle
    selectedIndex: -1

    onAccepted: {
        if(nameSelection.selectedIndex==nameSelection.model.count-1)
            dialog.open()
        else{
            name=nameSelection.model.get(nameSelection.selectedIndex).name
        }
    }

    CommonDialog {
        id: dialog
        visible: false
        titleText: "What's your name?"
        buttons: ToolBar {
            id: buttons
            width: parent.width
            height: privateStyle.toolBarHeightLandscape + 2 * platformStyle.paddingSmall

            tools: Row {
                anchors.centerIn: parent
                spacing: platformStyle.paddingMedium

                ToolButton {
                    text: "Save"
                    width: (buttons.width - 3 * platformStyle.paddingMedium) / 2
                    onClicked: dialog.accept()
                }

                ToolButton {
                    text: "Cancel"
                    width: (buttons.width - 3 * platformStyle.paddingMedium) / 2
                    onClicked: dialog.reject()
                }
            }
        }
        content:TextField {
            id: customName
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: "I'm..."
            width: parent.width - (2 * platformStyle.paddingLarge)
            focus: true
            text: nameSelection.name
        }
        onAccepted: name = customName.text
        onRejected: nameSelection.open() //if get here by mistake, user can save the score
    }
}
