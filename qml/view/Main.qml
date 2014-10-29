import QtQuick 2.2

Item {
    width: 900
    height: 700

    property ObjImage activeImageObject
    property double calculatedVolume : 0.0
    property double calculatedWeight : 0.0
    property bool dropCatched : false

    Image {
        width: parent.width
        height: parent.height
        source: "images/background.jpeg"
    }

    property int firstRowHeight: height/15
    property int secondRowHeight: (height - 2*firstRowHeight)/1.1

    DropArea {
        id : mainWin

        anchors{
            fill: parent
        }

        onDropped:  {
            if( dropCatched === false && drag.source !== null) {
                drag.source.opacity = 0
                reset()
            }
            dropCatched = false
        }

        /*first row, only one column*/
        ObjectCollectionWin {
            id: objectArea
            height: firstRowHeight
            width: mainWin.width

            anchors {
                top: mainWin.top
                left: mainWin.left
            }
            z:2
        }
        //invisible height after the object grid
        Rectangle {
            id: emptyAreaBelowObjs
            visible : false
            height : firstRowHeight
            width: mainWin.width

            anchors {
                top: objectArea.bottom
                left: objectArea.left
            }
            z:2
        }

        /*second row, first column*/
        WeightWin {
            id : weightArea
            height: secondRowHeight
            width: mainWin.width/4

            anchors {
                left: mainWin.left
                top: emptyAreaBelowObjs.bottom
            }

        }

        /*second row, second column*/
        VolumeWin {
            id: volArea
            height: secondRowHeight
            width: mainWin.width/4
            anchors {
                left: weightArea.right
                top: weightArea.top
            }
        }

        /*second row, third column*/
        DensityWin {
            id: densityArea
            height: secondRowHeight
            width: mainWin.width/2
            anchors {
                left: volArea.right
                top: emptyAreaBelowObjs.bottom
            }
        }
    }

    function setImageObject(imageObj) {
        dropCatched = true
        if(activeImageObject === null) {
            activeImageObject = imageObj
        }else {
            if(activeImageObject !== imageObj)
                console.log("Active object and received object are not same")
        }

    }

    function setVolume(volume) {
        calculatedVolume = volume
    }

    function setWeight(weight) {
        calculatedWeight = weight
    }

    function reset() {
        calculatedVolume = 0.0
        calculatedWeight = 0.0
        activeImageObject = null
        weightArea.reset()
        volArea.reset()
        densityArea.reset()
        if(activeImageObject !== null) {
            activeImageObject.opacity = 0
        }
    }

    function addValuesToFormula() {
        if(calculatedVolume > 0 && calculatedWeight > 0)
            densityArea.formulaWin.addValuesToFormula()
    }
}

