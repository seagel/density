import QtQuick 2.2

Item {
    id: mainWin
    width: 900
    height: 700

    property ObjImage activeImageObject
    property double calculatedVolume : 0.0
    property double calculatedWeight : 0.0

    Image {
        width: parent.width
        height: parent.height
        source: "images/background.jpeg"
    }

    property int firstRowHeight: mainWin.height/7
    property int secondRowHeight: (mainWin.height - firstRowHeight)/1.1

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

    /*second row, first column*/
    WeightWin {
        id : weightArea
        height: secondRowHeight
        width: mainWin.width/4

        anchors {
            left: mainWin.left
            top: objectArea.bottom
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
            top: objectArea.bottom
        }
    }

    function setImageObject(imageObj) {
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
    }

    function addValuesToFormula() {
        densityArea.formulaWin.addValuesToFormula()
    }
}

