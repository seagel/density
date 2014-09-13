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
            id : beakerDropArea

            onDropped: {
                drag.source.state = ""
                var density = drag.source.objectMass / drag.source.objectVolume
                var ldensity = beakerArea.objectDensity
                if (ldensity > density) {
                    namerecttext.text = "It floats !!"

                } else {
                    namerecttext.text = "It sinks !!"
                    drag.source.sinkRate = (density/ldensity) * 1000
                }

                drag.source.state = "moved"


            }

            //onEntered: maincanvas.state = Qt.new_method(1)
            Rectangle {
                x: 0
                y: 0
                anchors.fill: parent
                border.color: "green"
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                visible: parent.containsDrag
            }

    }


    Image {
        id: image2
        x: 230
        y: 212
        width: 200
        height: 218
        opacity: 0.22
        source: "beaker.png"
        Rectangle {
            id : beakerArea
            x: 36
            y: 79
            property real objectDensity
            width: 117
            height: 127
        }
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
                     x : 0
                     y : 0
                     source : image
                     property int objectMass : mass
                     property int objectVolume : volume
                     property string objectName : name
                     property real sinkRate : 100.0
                     Drag.source : object_image
                     Drag.active: dragArea.drag.active
                     signal selected(var selectedObject)
                     MouseArea {
                        id : dragArea
                        anchors.fill: parent
                        drag.target: parent
                        onClicked: object_image.selected(name)
                        onReleased : {
                            console.log("Hello")
                            parent.Drag.drop()
                        }
//                        onReleased: {
//                            namerecttext.text = qsTr("You have moved a " + name)
//                            mass_text.text = qsTr("Mass :: " +mass)
//                        }
                     }
                     onSelected: {
                         namerecttext.text = qsTr("You have selected a " + name)
                     }
                     states: [

                         State {
                             name: "moved"
                             PropertyChanges { target: object_image; y: y+30 }
                         }
                    ]
                     transitions: Transition {
                         NumberAnimation { duration: object_image.sinkRate; properties: "x,y"; easing.type: Easing.InOutQuad }
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

    GridView {
        id: grid_view1
        x: 436
        y: 168
        width: 51
        height: 267
        cellWidth: 70
        model: Qt.createComponent("liquids.qml").createObject(null)
        delegate: Item {
            x: 5
            height: 50
            Column {
                spacing: 5
                Rectangle {
                    id : ltype
                    width: 40
                    height: 40
                    color: lcolor
                    property string objectName : name
                    property real objectDensity : density
                    anchors.horizontalCenter: parent.horizontalCenter
                    signal selected()
                    MouseArea {
                        anchors.fill: parent
                        onClicked: ltype.selected()
                    }
                    onSelected: {
                        namerecttext.text = "You selected " + name + " Of " + density + " Density"
                        beakerArea.color = lcolor
                        beakerArea.objectDensity = density
                    }
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

