import QtQuick 2.0

Item {
    id : objectCollWin
    z : 5
    anchors {
        topMargin: objectCollWin.height * 0.1
    }

    ObjectList{
        id : objList
    }

    Grid {
        id : objGrid
        property bool dragEnabled : true
        rows: 1
        columns: 12
        spacing: 5

        property int cellWidth : objectCollWin.width/columns
        property int cellHeight: objectCollWin.height/rows

        Repeater {
                model: objGrid.rows * objGrid.columns

                ObjImage  {
                    width: objGrid.cellWidth - objList.getHorizontalSpacing(index, 5)
                    height: objGrid.cellHeight - objList.getVerticalSpacing(index, 5)

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
            fill : objectCollWin
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
