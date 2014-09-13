import QtQuick 2.0

Rectangle {
    id : maincanvas
    width: 500
    height: 500
    clip: false
    scale: 1

    Rectangle {
        id: namerectangle
        x: 145
        y: 30
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
            x: 265; y: 293
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

//    Image {
//        id: image1
//        x: 22
//        y: 104
//        width: 39
//        height: 39
//        property int weight: 100
//        property string object_name : "Stone"
//        source: "stone-clipart-rock-outline-md.png"
//        Drag.active: dragArea.drag.active

//        Drag.hotSpot.x: 10
//        Drag.hotSpot.y: 10
//        MouseArea {
//            id : dragArea
//            anchors.fill: parent
//            drag.target: parent
//            onClicked: maincanvas.state = "ClickedIcon"
//            //onDragChanged: maincanvas.state = "ClickedIcon"
//            //onReleased: parent.Drag.drop();
//        }
//        Component.onCompleted: {
//            var apple_object = Qt.createComponent("apple_object.qml")
//            var apple = apple_object.createObject(maincanvas, {"x":100, "y":100})
//            //image1.source = apple_object.apple_image.source
//        }

//    }

    Image {
        id: image2
        x: 230
        y: 212
        width: 200
        height: 218
        opacity: 0.22
        source: "beaker.png"
    }

    GridView {
        id: objects_grid
        x: 5
        y: 111
        width: 140
        height: 140
        cellWidth: 70
        model : Qt.createComponent("objects.qml").createObject(null);
        delegate: Item {
            x: 5
            height: 50
            Column {
                spacing: 5
                Rectangle {
                    width: 40
                    height: 40
                    Image {
                     id : object_image
                     width : 40
                     height : 40
                     source : image
                     property int objectMass : mass
                     property int objectVolume : volume
                     property string objectName : name

                     Drag.source : object_image
                     Drag.active: dragArea.drag.active
                     signal selected(var selectedObject)
                     MouseArea {
                        id : dragArea
                        anchors.fill: parent
                        drag.target: parent
                        onClicked: object_image.selected(name)
//                        onReleased: {
//                            namerecttext.text = qsTr("You have moved a " + name)
//                            mass_text.text = qsTr("Mass :: " +mass)
//                        }

                     }
                     onSelected: {
                         namerecttext.text = qsTr("You have selected a " + name)
                     }
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {

                    x: 5
                    text: name
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
        cellHeight: 70

    }

    Image {
        id: scale_object
        x: 25
        y: 293
        width: 100
        height: 100
        source: "scale.png"


    }
    DropArea {
            x: 25; y: 256
            clip: true
            width: 100; height: 37



            //onEntered: maincanvas.state = Qt.new_method(1)
            Rectangle {
                x: 0
                y: 0
                anchors.fill: parent
                opacity: 0.5
                border.color: "red"
                visible: parent.containsDrag
            }
            onEntered: {
                namerecttext.text = qsTr("You have moved a " + drag.source.objectName)
                mass_text.text = qsTr("Mass :: " + drag.source.objectMass)

            }

    }

    DropArea {
            x: 145; y: 222
            clip: true
            width: 85; height: 37



            //onEntered: maincanvas.state = Qt.new_method(1)
            Rectangle {
                x: 0
                y: 0
                anchors.fill: parent
                opacity: 0.5
                border.color: "red"
                visible: parent.containsDrag
            }
            onEntered: {
                namerecttext.text = qsTr("You have moved a " + drag.source.objectName)
                vol_text.text = qsTr("Volume :: " + drag.source.objectVolume)

            }

    }

    Text {
        id:vol_text
        x: 138
        y: 441
        width: 100
        height: 20
        text: qsTr("Volume :: ")
        font.pixelSize: 12
    }

    Image {
        id: image1
        x: 158
        y: 303
        width: 60
        height: 88
        scale : 2
        source: "mescynd.png"
    }

    Text {
        id: mass_text
        x: 23
        y: 413
        width: 100
        height: 20
        text: qsTr("Mass :: ")
        font.pixelSize: 12
    }


    states : [

        State {
            name : "ClickedIcon"
            PropertyChanges {
                target : namerecttext
                text : qsTr("You have selected a " + image1.name)
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

