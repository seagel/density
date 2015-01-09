import QtQuick 2.2

Item {
    width: 900
    height: 700

    property ObjImage activeImageObject
    property bool dropCatched : false

    Rectangle {
        anchors.fill: parent
        color: "#55ADAB"
        z:0
    }

    property int firstRowHeight: height/15
    property int secondRowHeight: height/5
    property int thirdRowHeight: (height - firstRowHeight - secondRowHeight)*0.8
    property int fourthRowHeight: height - firstRowHeight - secondRowHeight - thirdRowHeight
    property Note note
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
                resetAll(true)
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

        Item {
            id : noteObject
            width : 200
            height : 100
            anchors {
                top : objectArea.bottom
                left : objectArea.left
                leftMargin: -10
                topMargin: -5
            }

            Component.onCompleted:
                showNote()

            function showNote() {
                note = Qt.createQmlObject(
                    "Note{ \n" +
                    "rotation : 200\n" +
                    "textTopMargin: 5\n" +
                    "textLeftMargin: 50\n" +
                    "textWidth: 100\n" +
                    "textHeight: 100\n" +
                    "anchors.fill: parent\n" +
                    "text : \"Drag an object\"}\n" , noteObject, "note")
            }
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

        Item {
            id : noteWeight
            width : 150
            height : 200
            anchors {
                bottom : weightArea.bottom
                left : weightArea.right
                leftMargin: -30
            }

            function showNote() {
                note = Qt.createQmlObject(
                        "Note{ \n" +
                        "rotation : 100\n" +
                        "textTopMargin: 50\n" +
                        "textLeftMargin: 40\n" +
                        "textWidth: 100\n" +
                        "textHeight: 100\n" +
                        "anchors.fill: parent\n" +
                        "text : \" Drop the object to measure the mass\"}\n" , noteWeight, "note")
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

        Item {
            id : noteVolume
            width : 160
            height : 160
            anchors {
                bottom : volArea.bottom
                left : volArea.right
                leftMargin: -50
            }

            function showNote() {
                note = Qt.createQmlObject(
                    "Note{ \n" +
                    "rotation : 100\n" +
                    "textTopMargin: 30\n" +
                    "textLeftMargin: 45\n" +
                    "textWidth: 100\n" +
                    "textHeight: 100\n" +
                    "anchors.fill: parent\n" +
                    "text : \" Drag and drop the object to record the volume\"}\n" , noteVolume, "note")
            }
        }


        DensityWin {
            id: densityArea
            property int cellIndex : -1
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
                text : "Reset"
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
                    if(nextText.text == "Next") {
                        nextText.text = "Reset"
                        showWeightVolumeExperiment(true)
                        if( note !== null)
                            note.destroy()
                        noteObject.showNote()
                    }else{
                        resetAll(true)
                    }
                }
            }
       }

    }

    function setImageObject(imageObj) {
        dropCatched = true
        activeImageObject = imageObj
        showNote()
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

    function resetAll(force) {
        if(densityArea.visible == true) {
            showDensityExperiment(force)
        }else{
            showWeightVolumeExperiment(force)
        }
        if( note !== null)
            note.destroy()
        noteObject.showNote()
    }

    function showDensityExperiment(force) {
        if(note !== null)
            note.destroy()
        noteObject.showNote()

        weightArea.visible = false
        volArea.visible = false
        densityArea.reset(force)
        densityArea.visible = true
        densityArea.show()
        nextText.text = "Next"

        if(activeImageObject !== null) {
            densityArea.cellIndex = activeImageObject.getCellNumber()
        }
        if(force === true)
            reCreateGridObject(densityArea.cellIndex)

        activeImageObject = null
    }

    function showWeightVolumeExperiment(force) {
        weightArea.reset()
        volArea.reset()
        weightArea.visible = true
        volArea.visible = true
        densityArea.reset(true)
        densityArea.visible = false
        densityArea.hide()
        formulaArea.reset()

        if(force === true || activeImageObject !== null)
            reCreateGridObject(-1)

        activeImageObject = null
    }

    function showNote() {
        if( note !== null)
            note.destroy()
        note = null

        if(activeImageObject !== null) {
            var state = activeImageObject.getState()
            if(state == "inGrid") {
                noteWeight.showNote()
            } else if(state == "inWeight") {
                if(Number(formulaArea.getVolume()) > 0) {
                    note = formulaArea.getNote()
                }else{
                    noteVolume.showNote()
                }
            } else if(state == "inVolume") {
                if(Number(formulaArea.getWeight()) > 0) {
                    note = formulaArea.getNote()
                }else{
                    noteWeight.showNote()
                }
            } else if(state == "inBeaker") {
                note = densityArea.getNote()
            }
        }else{
            if(densityArea.visible === true)
                note = densityArea.getNote()
            else
                noteWeight.showNote()
        }
    }

}

