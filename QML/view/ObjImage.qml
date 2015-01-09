import QtQuick 2.0

Item {

    id : objImgId
    property string imgSource
    property string imgName
    property double weight : 0.00
    property double volume : 0.00
    property double density : 0.00
    property int cellNumber: 0
    z: 10
    state : "inGrid"

    Image {
        id : imageArea
        width: objImgId.width
        height: objImgId.height
        source: objImgId.imgSource
        z : 10

        Drag.active: imageMouseArea.drag.active
        Drag.source: objImgId

        MouseArea {
            id: imageMouseArea
            hoverEnabled: true
            anchors.fill: imageArea
            drag.target: imageArea

            onEntered: {
                imgText.textVisible = true
                imgText.mouseX = mouseX
                imgText.mouseY = mouseY
            }
            onMouseXChanged: {
                imgText.mouseX = mouseX
            }

            onMouseYChanged: {
                imgText.mouseY = mouseY
            }

            onExited: {
                imgText.textVisible = false
            }

            onPressed: {
                if(objImgId.state == "inGrid") {
                    parentReset(false)
                }
                objectPressed()
            }

            onReleased: {
                imgText.textVisible = false
                if(imageMouseArea.drag.active == true) {
                    objImgId.state = "none"
                    imageArea.Drag.drop()
                    if(objImgId.state == "none") {
                        parentReset(true)
                    }
                }
            }
        }

        Item {
            id : imgText
            property bool textVisible : false
            property real mouseX: 0
            property real mouseY: 0
            z : 10
            property alias textId:textId

            Text {
                id:textId
                x: imgText.mouseX - 2 * imgName.length
                y: imgText.mouseY + 30
                z: 100
                visible: imgText.textVisible
                text : imgName
                wrapMode: Text.WordWrap
            }

        }
    }
    function changePosition(x, y) {
        objImgId.y = y
        objImgId.x = x
    }


    states: [
        State {
            name: "inGrid"
        },
        State {
            name: "inWeight"
        },
        State {
            name: "inVolume"
        },
        State {
            name: "inBeaker"
        },
        State {
            name: "none"
        }
    ]

    function setState(newState) {
        state = newState
    }

    function updaetVolume(volume) {
        this.volume = volume
    }

    function getCalculatedVolume() {
        return (weight / density).toFixed();
    }

    function getVolume() {
        return volume;
    }

    /*
    How much is submerged depends on the density of the object, as compared to the fluid. The equation is:
            ρf * Vs = ρo * Vo
        where
            ρf is the density of the fluid
     Vs is the volume submerged
            ρo is the density of the object
        Vo is the volume of the whole object
            ρV is ρ times V
    */
    function getSubMergedHeight(liquidDensity) {
        var subMergedVol = (density * getCalculatedVolume()) / liquidDensity
        var subMergedPer =  subMergedVol / getCalculatedVolume()
        return height * subMergedPer
    }

    function getSinkStatus(liquidDensity) {
        if(getSubMergedHeight(liquidDensity) < height) {
            return "Float"
        }else{
            return "Sinks"
        }
    }
    function getCellNumber() {
        return objImgId.cellNumber
    }

    Behavior on x {
        PropertyAnimation { duration: 400; }
    }
    Behavior on y {
        PropertyAnimation { duration: 400; }
    }

    function getDuplicateObject() {
        var qmlStr = "import QtQuick 2.0; ObjImage  { " + "\n" +
                                    "width: " + objImgId.width + "\n" +
                                    "height: " + objImgId.height + "\n" +
                                    "imgSource : \"" +  objImgId.imgSource + "\"\n" +
                                    "imgName : \"" + objImgId.imgName + "\"\n" +
                                    "weight : " + objImgId.weight + "\n" +
                                    "density: " + objImgId.density + "\n" +
                                    "opacity : " + objImgId.opacity + "\n" +
                                    "cellNumber : " + objImgId.cellNumber + "\n" +
                                    "x : " + x + "\n" +
                                    "y : " + y + "\n" +
                                    "z : " + z + "\n }" + "\n"

        return objImgId.parent.getNewObject(qmlStr)
    }

    function getDensity() {
        return density
    }

    function getState() {
        return state
    }

    function parentReset(force) {
        objImgId.parent.parentReset(force)
    }

    function objectPressed() {
        parent.objectPressed()
    }

    function reset() {

    }
}
