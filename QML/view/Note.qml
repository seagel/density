import QtQuick 2.2

Item {
    id : note
    property int rotation: 0
    property string text: ""
    property int textTopMargin: 0
    property int textLeftMargin: 0
    property int textWidth: 0
    property int textHeight: 0

    Image {
        anchors.fill: parent
        source : "images/note.png"
        rotation: parent.rotation
        opacity : 0.8
    }
    TextEdit {
        width : parent.textWidth
        height : parent.textHeight
        anchors {
            left : note.left
            top : note.top
            topMargin: parent.textTopMargin
            leftMargin: parent.textLeftMargin
        }

        text : note.text
        wrapMode: TextEdit.WordWrap
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        readOnly: true
    }

}

