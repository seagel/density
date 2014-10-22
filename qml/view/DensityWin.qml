import QtQuick 2.0
import QtQuick.Controls 1.2

Item {
        id : densityWin
        //width: densityWin.width
        //height: densityWin.height
        property ObjImage droppedObject
        property double beakerPointHt : (densityExperimentArea.height / 1.20) / 50
        property double liquidLevel : 30 * beakerPointHt

        FormulaWin {
            id: formulaArea
            width: densityWin.width
            height: (1*densityWin.height)/10
        }

        Image {
            id: densityExperimentArea
            visible: false
            width: densityWin.width
            height: (4.7*densityWin.height)/10
            source: "images/beaker.png"
            anchors {
                left : formulaArea.left
                top : formulaArea.bottom
            }
        }

        Item {
            id: liquidTypeArea
            visible: false
            width: densityWin.width
            height: (1.3*densityWin.height)/10
            anchors {
                left : densityExperimentArea.left
                top : densityExperimentArea.bottom
            }
            LiquidTypeList{
                id : liquidList
            }
            Grid {
                id : liquidButtonGrid
                property int divideFactor : 4
                rows: (liquidList.liquidTypeList.length / divideFactor) + 1
                columns: divideFactor
                spacing: 5
                anchors.fill : liquidTypeArea

                property int cellWidth : (liquidTypeArea.width-(spacing*columns))/columns
                property int cellHeight: (liquidTypeArea.height-(spacing*columns))/rows

                Repeater {
                        model: liquidButtonGrid.rows * liquidButtonGrid.columns

                        Rectangle  {
                            id : liqTypeButton
                            width: liquidButtonGrid.cellWidth
                            height: liquidButtonGrid.cellHeight
                            radius : 5
                            border.width: 1
                            border.color : "red"
                            signal clicked

                            Text {
                                id : liquidText
                                text : liquidList.liquidTypeList.length > index ? liquidList.liquidTypeList[index].recName : "test"
                                font.bold: true
                                anchors.fill : parent
                                anchors.centerIn: parent
                                horizontalAlignment: TextEdit.AlignHCenter
                                verticalAlignment: TextEdit.AlignVCenter
                                font.pixelSize: parent.height/2
                                color: "red"
                            }

                            color : liquidList.getColor(index, "black")
                            opacity : liquidList.getOpacity(index, 1)
                            visible : liquidList.validIndex(index) ? true : false
                            property double liqDensity : liquidList.getDensity(index, 1)

                            MouseArea {
                                id : buttonMouseArea
                                anchors.fill: parent
                                onClicked : {
                                    liquidArea.density = liqDensity
                                    liquidArea.type = liquidText.text
                                    liquidArea.color = color
                                }
                            }
                       }

                }
            }
        }

        ResultsView {
            id : resultsGrid
            width: densityWin.width
            height: (4 * densityWin.height)/10
            anchors {
                left : liquidTypeArea.left
                //TODO:
                top : liquidTypeArea.bottom
                //leftMargin: 20
                //bottomMargin: 20
            }
        }

        Rectangle {
            id : liquidArea
            visible : false
            height : densityWin.liquidLevel
            width : densityExperimentArea.width/2
            property double density: 1
            property string type: "water"


            anchors {
                left : densityExperimentArea.left
                bottom : densityExperimentArea.bottom
                leftMargin: densityExperimentArea.width/3.7
                bottomMargin: densityExperimentArea.height/10

            }
            radius: 20
            opacity : 0.3
            color : "blue"

        }

        Rectangle {
            id : dropAreaRect
            property double botMargin: densityExperimentArea.height/10
            height : densityExperimentArea.height - botMargin
            width : densityExperimentArea.width/2

            anchors {
                left : densityExperimentArea.left
                bottom : densityExperimentArea.bottom
                leftMargin: densityExperimentArea.width/3.7
                bottomMargin: botMargin

            }
            radius: 20
            visible : false
        }

        DropArea {
            id : dropArea
            property bool sinks: false
            anchors.fill:dropAreaRect
            visible: false
             onEntered: {
                 drag.source.opacity = 0.5
             }

             onDropped:  {
                 sinks = false
                 droppedObject = drag.source
                 droppedObject.changePosition(droppedObject.x, droppedObject.y + (height - drag.y - getObjectBottomSinkLevel(liquidArea.density)))
                 droppedObject.setState("inBeaker")
                 droppedObject.disableParentDragging()
                 //updateWaterLevel(drag.source.volume/10)
                 resultsGrid.addRow(droppedObject.imgName, liquidArea.type, liquidArea.density, droppedObject.getSinkStatus(liquidArea.density))

             }
             onExited: {
                drag.source.opacity = 1
                droppedObject.setState("none")
             }
        }

        function showDensityExperiment(show) {
            if( show === true) {
                dropArea.visible = true
                liquidArea.visible = true
                liquidTypeArea.visible = true
                densityExperimentArea.visible = true
            }else{
                dropArea.visible = false
                liquidArea.visible = false
                densityExperimentArea.visible = false
                liquidTypeArea.visible = false
            }
        }

        function reset() {
            droppedObject = null
            showDensityExperiment(false)
            liquidArea.height = liquidLevel
            formulaArea.reset()
        }

        function getObjectBottomSinkLevel(liquidDensity) {
            var objectFloatHt = droppedObject.height - droppedObject.getSubMergedHeight(liquidDensity)
            if(objectFloatHt <= 0 ) {
                return droppedObject.height
            }else{
                return liquidArea.height + objectFloatHt
            }
        }
}
