import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0

Flickable {
    id : volumeWin
    width: volumeWin.width
    height: volumeWin.height
    /* these are bindings, changing these values automatically adjust the objects*/
    property double cylinderPointHt : cylinderImage.height/15.4 //45
    property double increasePointHt : 0
    property double initialWaterLevelPoints : 6
    property double initialCylinderStartPoint : 1
    property double totalCylinderLevel : 13.3
    property double liquidLevel : (initialWaterLevelPoints - initialCylinderStartPoint + increasePointHt) * volumeWin.cylinderPointHt
    property ObjImage droppedObject

    Image {
        id : cylinderImage
        width: volumeWin.width
        height: volumeWin.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        source : "images/graduated_cylinder.png"
        z : 1
    }

    Rectangle {
        id : baseArea
        width: cylinderImage.width
        height: cylinderImage.height/5.1
        anchors {
            bottom: cylinderImage.bottom
            left: cylinderImage.left
        }
        visible: false
    }

    Rectangle {
        id : waterArea
        width: cylinderImage.width/2.233
        height: volumeWin.liquidLevel
        opacity : 0.3
        color : "blue"
        z : 2
        anchors {
            bottom: baseArea.top
            left: cylinderImage.left
            leftMargin: cylinderImage.width/3.5
        }

//        Behavior on height {
//            PropertyAnimation { duration: 400; }
//        }
    }

    Rectangle {
        id : cylinderArea
        width: cylinderImage.width/2.233
        height: (totalCylinderLevel - 1) * volumeWin.cylinderPointHt
        anchors {
            bottom: baseArea.top
            left: waterArea.left
        }
        visible: false
        z : 2
    }

    TextEdit {
        id : volumeText
        width: baseArea.width/2
        height: baseArea.height/2
        font.pixelSize: height/1.8
        textFormat: TextEdit.AutoText
        color: "red"
        text: droppedObject == null ? "00.00" : droppedObject.getCalculatedVolume()
        horizontalAlignment: TextEdit.AlignHCenter
        verticalAlignment: TextEdit.AlignVCenter

        anchors.horizontalCenter: baseArea.horizontalCenter
        anchors.bottom: baseArea.bottom
        anchors.bottomMargin: baseArea.height/2

        z : 5
    }


    DropArea {
         anchors.fill: cylinderArea
         onEntered: {
             drag.source.opacity = 0.5
         }

         onDropped:  {
             droppedObject = drag.source
             droppedObject.setState("inVolume")
             droppedObject.disableParentDragging()
             updateWaterLevel(droppedObject.getCalculatedVolume()/10)
             droppedObject.changePosition(droppedObject.x, droppedObject.y + (height - drag.y - getObjectBottomSinkLevel(1)))
             volumeText.text = droppedObject.getCalculatedVolume()
             setImageObject(droppedObject)
             setVolume(droppedObject.getCalculatedVolume())
             addValuesToFormula()
         }
         onExited: {
             if(droppedObject !== null ) {
                 if(droppedObject.state == "inVolume") {
                    increasePointHt = 0
                 }
                droppedObject.setState("none")
                droppedObject = null
             }
             drag.source.opacity = 1
         }
    }

    function updateWaterLevel(increasePointHeight) {
        increasePointHt = increasePointHeight
    }

    function getObjectBottomSinkLevel(liquidDensity) {
        var objectFloatHt = droppedObject.height - droppedObject.getSubMergedHeight(liquidDensity)
        if(objectFloatHt <= 0 ) {
            return droppedObject.height
        }else{
            return waterArea.height + objectFloatHt
        }
    }

    function reset() {
        droppedObject = null
        volumeText.text = "00.00"
        increasePointHt = 0
    }
}
