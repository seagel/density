import QtQuick 2.0

Item {
    id : objectCollWin
    z : 5
    property ObjImage imgObj
    property int objIndex: -1

    anchors {
        topMargin: objectCollWin.height * 0.1
        leftMargin: objectCollWin.width * 0.15
    }

    ObjectList{
        id : objList
    }

    Grid {
        id : objGrid
        rows: 1
        columns: (objIndex !== -1) ? 1 : objList.getLength()
        spacing: 10
        property int cellWidth : objectCollWin.width/objList.getLength()
        property int cellHeight: objectCollWin.height/rows


        Repeater {
                id : gridRepeater
                model: objGrid.rows * objGrid.columns

                Item {
                    property int currObjIndex: (objIndex !== -1) ? objIndex : index
                    Component.onCompleted:
                                            objGrid.getNewObject(
                                               "import QtQuick 2.0; ObjImage  { "  + "\n" +
                                                                          "width: " + (objGrid.cellWidth - objList.getHorizontalSpacing(currObjIndex, 5)) + "\n" +
                                                                          "height: " + (objGrid.cellHeight - objList.getVerticalSpacing(currObjIndex, 5)) + "\n" +
                                                                          "imgSource : \"" +  objList.getSource(currObjIndex, "") + "\"\n" +
                                                                          "imgName : \"" + objList.getName(currObjIndex, "") + "\"\n" +
                                                                          "weight : " + objList.getWeight(currObjIndex, "00.00") + "\n" +
                                                                          "density: " + objList.getDensity(currObjIndex, "00.00") + "\n" +
                                                                          "opacity : " + (objList.validIndex(currObjIndex) ? 1 : 0) + "\n" +
                                                                          "cellNumber : " + currObjIndex + "\n" +
                                                                          " }" + "\n"
                                               )
                }
        }
        function parentReset(force) {
            objGrid.parent.parentReset(force)
        }

        function getNewObject(qmlDynamicObj) {
            return Qt.createQmlObject( qmlDynamicObj,
                                                    objGrid,
                                                    "objImgId"
                                                   );
        }
        function objectPressed() {
            parent.objectPressed()
        }

    }

    function parentReset(force) {
        resetAll(force)
    }
    function objectPressed() {
        showNote()
    }

}
