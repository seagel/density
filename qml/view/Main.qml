import QtQuick 2.2

Item {
    width: 900
    height: 700

    property ObjImage activeImageObject
    property bool dropCatched : false

    Rectangle {
        anchors.fill: parent
        color: "#49BAB6"
        z:0
    }

    property int firstRowHeight: height/15
    property int secondRowHeight: height/5
    property int thirdRowHeight: (height - firstRowHeight - secondRowHeight)*0.8
    property int fourthRowHeight: height - firstRowHeight - secondRowHeight - thirdRowHeight
    property ObjectCollectionWin objGrid

    ObjectList{
        id : objImageList
    }

    DropArea {
        id : mainWin
        width: parent.width
        height: parent.height
        anchors{
            fill: parent
        }

        onDropped:  {
            if(activeImageObject === null) {
                activeImageObject = drag.source
            }

            if( dropCatched === false && drag.source !== null) {
                reset(true)
            }
            dropCatched = false
        }

        Item {
            id : objectArea
            height: firstRowHeight
            width: mainWin.width * 0.82
            anchors {
                top: mainWin.top
                left: mainWin.left
                topMargin: firstRowHeight * 0.3
            }
            z:2

            Component.onCompleted:
                reCreateGridObject(-1)
        }

        FormulaWin {
            id: formulaArea
            height : secondRowHeight
            width: mainWin.width

            anchors {
                top: objectArea.bottom
                left: mainWin.left
            }
            z:2
        }

        WeightWin {
            id : weightArea
            height: thirdRowHeight
            width: mainWin.width/4

            anchors {
                left: mainWin.left
                top: formulaArea.bottom
                leftMargin: width/2
            }
        }

        VolumeWin {
            id: volArea
            height: thirdRowHeight
            width: mainWin.width/4
            anchors {
                left: weightArea.right
                top: weightArea.top
                leftMargin: width/2
            }
        }

        DensityWin {
            id: densityArea
            height: thirdRowHeight
            width: mainWin.width
            visible: false
            anchors {
                left: mainWin.left
                top: formulaArea.bottom
            }
        }
        Rectangle  {
            id : nextButton
            width: 100
            height: fourthRowHeight/3
            border.width: 1
            border.color : "red"
            anchors {
                right : mainWin.right
                top : densityArea.bottom
                topMargin: height * 0.4
                rightMargin: mainWin.width * 0.025

            }

            color : "yellow"
            signal clicked

            Text {
                id : nextText
                text : "reset"
                font.bold: true
                anchors.fill : parent
                anchors.centerIn: parent
                horizontalAlignment: TextEdit.AlignHCenter
                verticalAlignment: TextEdit.AlignVCenter
                font.pixelSize: parent.height/2
                color: "red"
            }

            MouseArea {
                id : buttonMouseArea
                anchors.fill: parent
                onClicked : {
                    if(nextText.text == "next") {
                        nextText.text = "reset"
                        showWeightVolumeExperiment(true)
                    }else{
                        reset(true)
                    }
                }
            }
       }

    }

    function setImageObject(imageObj) {
        dropCatched = true
        activeImageObject = imageObj
    }

    function setVolume(volume) {
        formulaArea.updateVolume(volume)
    }

    function setWeight(weight) {
        formulaArea.updateWeight(weight)
    }

    function reCreateGridObject(objImageIndex) {

        if(objGrid !== null)
            objGrid.destroy()

        objGrid = Qt.createQmlObject(
        "import QtQuick 2.0;  ObjectCollectionWin { " + "\n" +
        "height: " + firstRowHeight + "\n" +
        "width: " + (mainWin.width * 0.82) + "\n" +
        "objIndex: " + objImageIndex + "\n" +
            "anchors { " + "\n" +
                "top: mainWin.top " + "\n" +
                "left: mainWin.left " + "\n" +
                "topMargin: " + (firstRowHeight * 0.3) + "\n" +
            "} " + "\n" +
            "z:2" + "\n" +
        "}\n", mainWin, "objArea")
    }

    function reset(force) {
        if(densityArea.visible == true) {
            showDensityExperiment()
        }else{
            showWeightVolumeExperiment(force)
        }
    }

    function showDensityExperiment() {
        weightArea.visible = false
        volArea.visible = false
        densityArea.reset()
        densityArea.visible = true
        densityArea.show()
        nextText.text = "next"

        if(activeImageObject !== null) {
            reCreateGridObject(activeImageObject.getCellNumber())
        }

        activeImageObject = null
    }

    function showWeightVolumeExperiment(force) {
        weightArea.reset()
        volArea.reset()
        weightArea.visible = true
        volArea.visible = true
        densityArea.visible = false
        densityArea.hide()
        formulaArea.reset()

        if(force === true || activeImageObject !== null)
            reCreateGridObject(-1)

        activeImageObject = null
    }

}

