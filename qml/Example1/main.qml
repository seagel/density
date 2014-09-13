import QtQuick 2.0

Rectangle {
    id : maincanvas
    width: 500
    height: 500
    clip: false
    scale: 1

    Rectangle {
        id: namerectangle
        x: 150
        y: 94
        width: 200
        height: 71
        color: "#ffffff"
        Text {
            id : namerecttext
            text : qsTr("")
            anchors.centerIn: parent
        }
    }
    DropArea {
            x: 187; y: 293
            width: 116; height: 125
            onEntered: maincanvas.state = "IconDropped"
            //onEntered: maincanvas.state = Qt.new_method(1)
            Rectangle {
                x: 0
                y: 0
                anchors.fill: parent
                color: "green"
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                visible: parent.containsDrag
            }

    }
    Image {
        id: image1
        x: 22
        y: 104
        width: 39
        height: 39
        property int weight: 100
        property string object_name : "Stone"
        source: "stone-clipart-rock-outline-md.png"
        Drag.active: dragArea.drag.active
        Drag.hotSpot.x: 10
        Drag.hotSpot.y: 10
        MouseArea {
            id : dragArea
            anchors.fill: parent
            drag.target: parent
            onClicked: maincanvas.state = "ClickedIcon"
            //onDragChanged: maincanvas.state = "ClickedIcon"
            //onReleased: parent.Drag.drop();
        }

    }

    Image {
        id: image2
        x: 150
        y: 212
        width: 200
        height: 218
        opacity: 0.22
        source: "beaker.png"
    }
    states : [

        State {
            name : "ClickedIcon"
            PropertyChanges {
                target : namerecttext
                text : qsTr("You have selected a " + image1.object_name + " of Mass : " + image1.weight)
            }
        },
        State {
            name : "IconDropped"
            PropertyChanges {
                target : namerecttext
                text : qsTr("You moved a stone")
            }
        }
    ]
}

