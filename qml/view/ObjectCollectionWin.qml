import QtQuick 2.0

Item {
    id : objectCollWin
    z : 5
    anchors {
        topMargin: objectCollWin.height * 0.1
        leftMargin: objectCollWin.width * 0.1
    }

    ObjectList{
        id : objList
    }

    Grid {
        id : objGrid
        rows: 1
        columns: 12
        spacing: 5
        property int cellWidth : objectCollWin.width/columns
        property int cellHeight: objectCollWin.height/rows

        Repeater {
                model: objGrid.rows * objGrid.columns

                Item {
                    Component.onCompleted: objGrid.getNewObject(
                                               "import QtQuick 2.0; ObjImage  { "  + "\n" +
                                                                          "width: " + (objGrid.cellWidth - objList.getHorizontalSpacing(index, 5)) + "\n" +
                                                                          "height: " + (objGrid.cellHeight - objList.getVerticalSpacing(index, 5)) + "\n" +
                                                                          "imgSource : \"" +  objList.getSource(index, "") + "\"\n" +
                                                                          "imgName : \"" + objList.getName(index, "") + "\"\n" +
                                                                          "weight : " + objList.getWeight(index, "00.00") + "\n" +
                                                                          "density: " + objList.getDensity(index, "00.00") + "\n" +
                                                                          "opacity : " + (objList.validIndex(index) ? 1 : 0) + "\n" +
                                                                          " }" + "\n"
                                               )
                }
        }
        function parentReset() {
            objGrid.parent.parentReset()
        }

        function getNewObject(qmlDynamicObj) {
            return Qt.createQmlObject( qmlDynamicObj,
                                                    objGrid,
                                                    "objImgId"
                                                   );
        }

    }

    function parentReset() {
        reset()
    }

}
