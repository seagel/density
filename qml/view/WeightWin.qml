import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0

Item {
        id : weightWin
        width: weightWin.width
        height: weightWin.height
        property ObjImage droppedObject

        Image {
            id : weighingScaleArea
            width: weightWin.width/1.5
            height: weightWin.height/3
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            source : "images/weighing_scale1.png"
        }

        DropArea {
            id : dropArea
            height:  weightWin.height - weighingScaleArea.height
            width: weighingScaleArea.width - 50

            anchors{
                bottom : weighingScaleArea.top
                left : weighingScaleArea.left
            }

            onDropped:  {
                drag.source.opacity = 1
                droppedObject = drag.source                
                droppedObject.changePosition(droppedObject.x, droppedObject.y + (height - drag.y) - droppedObject.height)
                droppedObject.setState("inWeight")
                weightText.text = droppedObject.weight
                setImageObject(droppedObject)
                setWeight(droppedObject.weight)
            }

            onEntered: {
                drag.source.opacity = 0.5
            }

             onExited: {
                 drag.source.opacity = 1
             }
        }

        Text {
            id : wightUnit
            text: "Grams"
            anchors.bottom: weightText.top
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id : weightText
            width: weighingScaleArea.width
            height: weighingScaleArea.height/5
            font.pixelSize: height/1.3
            textFormat: TextEdit.AutoText
            color: "yellow"

            text: "00.00"
            horizontalAlignment: TextEdit.AlignHCenter
            verticalAlignment: TextEdit.AlignVCenter

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: height/2.4

        }

        function getActiveObject() {
            return droppedObject;
        }

        function reset() {
            weightText.text = "00.00"
            droppedObject = null
        }
}
