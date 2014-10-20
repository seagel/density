import QtQuick 2.0

Flickable {
    id : objectCollWin
    topMargin: objectCollWin.height*0.03
    leftMargin: objectCollWin.width*0.01
    ObjectList{
        id : objList
    }
    z : 5
    Grid {
        id : objGrid
        property bool dragEnabled : true
        rows: 1
        columns: 12
        spacing: 5

        property int cellWidth : (objectCollWin.width-(spacing*columns))/columns
        property int cellHeight: (objectCollWin.height-(spacing*columns))/rows

        Repeater {
                model: objGrid.rows * objGrid.columns

                ObjImage  {
                    width: objGrid.cellWidth
                    height: objGrid.cellHeight

                    imgSource : objList.getSource(index, "")
                    imgName : objList.getName(index, "")
                    weight : objList.getWeight(index, "00.00")
                    density: objList.getDensity(index, "00.00")
                    opacity : objList.validIndex(index) ? 1 : 0
                    z: 5
               }

        }

        function enableDragging() {
            objGrid.dragEnabled = true
        }

        function disableDragging() {
            objGrid.dragEnabled = false
        }

    }

    DropArea {
        id : dropArea

        anchors{
            fill : parent
        }

        onDropped:  {
            reset(drag.source)
        }
    }
    function reset(imageObject) {
        objGrid.enableDragging()
        imageObject.setState("inGrid")
        parent.reset()
    }
}
