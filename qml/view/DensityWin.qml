import QtQuick 2.0
import QtQuick.Controls 1.2

Item {
        id : densityWin
        property ObjImage droppedObject
        property double beakerPointHt : (densityExperimentArea.height / 1.20) / 50
        property double liquidLevel : 30 * beakerPointHt

        Image {
            id: densityExperimentArea
            width: (5 * densityWin.width)/10
            height: densityWin.height * 0.8
            source: "images/beaker.png"
            anchors {
                bottom : densityWin.bottom
                left : densityWin.left
                leftMargin: width * 0.1
            }
        }

        Item {
            id: liquidTypeArea
            width: (1.1 * densityWin.width)/10
            height: densityWin.height
            anchors {
                left : densityWin.left
                bottom : densityWin.bottom
                leftMargin: liquidTypeArea.width * 0.1
            }

            LiquidTypeList{
                id : liquidList
            }
            Grid {
                id : liquidButtonGrid
                rows: 3 * liquidList.liquidTypeList.length
                columns: 1
                spacing: 5
                anchors {
                    right : liquidTypeArea.right
                    bottom : liquidTypeArea.bottom
                    bottomMargin: liquidTypeArea.width * 0.2
                }

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
                                color: "black"
                            }

                            color : liquidList.getColor(index, "black")
                            opacity : liquidList.getOpacity(index, 1)
                            visible : liquidList.validIndex(index) ? true : false
                            property double liqDensity : liquidList.getDensity(index, 1)

                            MouseArea {
                                id : buttonMouseArea
                                anchors.fill: parent
                                onClicked : {
                                    if(liquidArea.type.toUpperCase() !== liquidText.text.toUpperCase()) {
                                        if(droppedObject !== null && droppedObject.state == "inBeaker" ) {
                                            droppedObject.changePosition(droppedObject.x, droppedObject.y+getLiquidBottomToObjectTopHeight(liquidArea.density)-getLiquidBottomToObjectTopHeight(liqDensity))
                                            liquidArea.density = liqDensity
                                            liquidArea.type = liquidText.text
                                            if(liquidArea.color !== color){
                                                resultsGrid.addRow(droppedObject.imgName, liquidArea.type, liquidArea.density, droppedObject.getSinkStatus(liquidArea.density))
                                            }
                                        }
                                        liquidArea.density = liqDensity
                                        liquidArea.type = liquidText.text
                                        liquidArea.color = color
                                    }
                                }
                            }
                       }

                }
            }
        }

        ResultsView {
            id : resultsGrid
            width: (5*densityWin.width)/10
            height: densityWin.height
            anchors {
                right : densityWin.right
                rightMargin: width * 0.05
            }
        }

        Rectangle {
            id : liquidArea
            height : densityWin.liquidLevel
            width : densityExperimentArea.width/2
            property double density: 1
            property string type: "Water"

            anchors {
                left : densityExperimentArea.left
                bottom : densityExperimentArea.bottom
                leftMargin: densityExperimentArea.width/3.7
                bottomMargin: densityExperimentArea.height/10

            }
            radius: 20
            opacity : 0.3
            color : "#006aff"

        }

        Rectangle {
            id : dropAreaRect
            visible: false
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
        }

        DropArea {
            id : dropArea
            property bool sinks: false
            anchors.fill:dropAreaRect
             onEntered: {
                 drag.source.opacity = 0.5
             }

             onDropped:  {
                 sinks = false
                 droppedObject = drag.source
                 droppedObject.changePosition(droppedObject.x, droppedObject.y + (height - drag.y - getLiquidBottomToObjectTopHeight(liquidArea.density)))
                 droppedObject.setState("inBeaker")
                 resultsGrid.addRow(droppedObject.imgName, liquidArea.type, liquidArea.density, droppedObject.getSinkStatus(liquidArea.density))
                 setImageObject(droppedObject)
             }
             onExited: {
                drag.source.opacity = 1
                drag.source.setState("none")
                droppedObject = null
             }
        }

        function show() {
            dropArea.visible = true
            liquidArea.visible = true
            liquidTypeArea.visible = true
            densityExperimentArea.visible = true
        }

        function hide() {
            dropArea.visible = false
            liquidArea.visible = false
            densityExperimentArea.visible = false
            liquidTypeArea.visible = false
        }

        function reset() {
            liquidArea.height = liquidLevel
            liquidArea.color = "#006aff"
            liquidArea.opacity = 0.3
            droppedObject = null
        }

        function getLiquidBottomToObjectTopHeight(liquidDensity) {
            var objectFloatHt = droppedObject.height - droppedObject.getSubMergedHeight(liquidDensity)
            if(objectFloatHt <= 0 ) {
                return droppedObject.height
            }else{
                return liquidArea.height + objectFloatHt
            }
        }
}
