import QtQuick 2.0
import QtQuick.Controls.Styles 1.2

Item {
    id: formulaArea
    property int textHeight: height/6

    Rectangle {
        id : topEmptyArea
        height: formulaArea.height * 0.2
        width: formulaArea.width
        color: "lightgreen"
        visible: false
    }

    Rectangle{
        id : leftEmptyArea
        width: formulaArea.width * 0.2
        height: formulaArea.height
        color: "lightgreen"
        anchors.top: topEmptyArea.bottom
        visible: false
    }

    Text {
        id: densityText
        width: getTextWidth("Density(ρ)")
        text: "Density(ρ) "
        font.pixelSize: formulaArea.textHeight
        font.bold: true
        textFormat: TextEdit.AutoText
        color: "yellow"
        anchors.left: leftEmptyArea.right
        anchors.top: topEmptyArea.bottom
    }

    Text {
        id: equalText
        width: getTextWidth(" = ")
        text: " = "
        font.pixelSize: formulaArea.textHeight
        font.bold: true
        textFormat: TextEdit.AutoText
        color: "yellow"
        anchors {
            left : densityText.right
            top: topEmptyArea.bottom
        }
    }

    Text {
        id: massText
        width: getTextWidth("Mass(m) ")
        text: "Mass(m) "
        font.pixelSize: formulaArea.textHeight
        font.bold: true
        textFormat: TextEdit.AutoText
        color: "yellow"
        anchors.left: equalText.right
        anchors.top: topEmptyArea.bottom

    }

    Text {
        id: divideText
        width: getTextWidth(" /")
        text: " /"
        font.pixelSize: formulaArea.textHeight
        font.bold: true
        textFormat: TextEdit.AutoText
        color: "yellow"
        anchors.left: massText.right
        anchors.top: topEmptyArea.bottom
    }

    Text {
        id: volumeText
        width: getTextWidth("Volume(v)")
        text: "Volume(v)"
        font.pixelSize: formulaArea.textHeight
        font.bold: true
        textFormat: TextEdit.AutoText
        color: "yellow"
        anchors.left: divideText.right
        anchors.top: topEmptyArea.bottom
    }

    TextInput {
        id: densityInput
        width: densityText.width - getTextWidth("gm/c")
        height: densityText.height
        anchors {
            left : densityText.left
            top : densityText.bottom
        }
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        color : "red"
        font.bold: true
        text : "0"
        font.pixelSize: formulaArea.textHeight * 0.7
        focus : true
        Rectangle {
            anchors.fill: parent
            opacity: 0.2
            border.color: "red"
        }
        autoScroll: false
        validator: DoubleValidator {
            bottom: 0
            top: 1e10
            decimals: 2
        }
        maximumLength: 9

        onTextChanged : {
            if(densityMatching()) {
                showDensityExperiment(true)
                readOnly = true
            }
        }

    }

    Text {
        id : densityResultUnits
        height : densityInput.height
        width : getTextWidth("gm/cm3")
        text: " gm/cm3"
        color: "black"
        anchors {
            left : densityInput.right
            top : densityInput.top
        }
        font.pixelSize: formulaArea.textHeight  * 0.7
        textFormat: TextEdit.AutoText
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter

    }


    Text {
        id: massResultText
        width: massText.width - getTextWidth("gm")
        height: massText.height
        text: "0"
        font.pixelSize: formulaArea.textHeight  * 0.7
        textFormat: TextEdit.AutoText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "red"
        font.bold: true
        Rectangle {
            anchors.fill: parent
            opacity: 0.2
            border.color: "red"
        }
        anchors {
            left : massText.left
            top : massText.bottom
        }
    }

    Text {
        id : massResultUnits
        height : massResultText.height
        width : getTextWidth("gm")
        text: " gm"
        color: "black"
        anchors {
            left : massResultText.right
            top : massResultText.top
        }
        font.pixelSize: formulaArea.textHeight  * 0.7
        textFormat: TextEdit.AutoText
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter

    }

    Text {
        id: volumeResultText
        width: volumeText.width - getTextWidth("cm3")
        height: volumeText.height
        text: "0"
        font.pixelSize: formulaArea.textHeight  * 0.7
        textFormat: TextEdit.AutoText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "red"
        font.bold: true
        Rectangle {
            anchors.fill: parent
            opacity: 0.2
            border.color: "red"
        }
        anchors {
            left : volumeText.left
            top : volumeText.bottom
        }
    }

    Text {
        id : volumeResultUnits
        height : volumeResultText.height
        width : getTextWidth("cm3")
        text: " cm3"
        color: "black"
        anchors {
            left : volumeResultText.right
            top : volumeResultText.top
        }
        font.pixelSize: formulaArea.textHeight  * 0.7
        textFormat: TextEdit.AutoText
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter

    }


    function getTextWidth(text) {
        return (text.length) * (formulaArea.textHeight * 0.8)
    }

    function updateVolume(volume) {
        volumeResultText.text = volume.toString()
    }

    function updateWeight(mass) {
        massResultText.text = mass.toString()
    }

    function densityMatching() {
        if(Number(densityInput.text) > 0 && Number(massResultText.text) > 0 && Number(volumeResultText.text) > 0) {
            var calculatedDensity = Number(massResultText.text)/Number(volumeResultText.text)
            calculatedDensity = Math.floor((calculatedDensity * 10 * 10))/100
            var inputDensity = Number(densityInput.text)
            if(inputDensity == calculatedDensity)
                return true
        }
        return false
    }

    function reset() {
        densityInput.text = "0"
        massResultText.text = "0"
        volumeResultText.text = "0"
        densityInput.readOnly = false
    }
}
