import QtQuick 2.0
import QtQuick.Controls.Styles 1.2

Item {
    id: formulaArea
    Text {
        id: fullFormulaText1
        width: formulaArea.width / 3
        height: formulaArea.height / 2
        text: "Density(d) = "
        horizontalAlignment: Text.AlignRight
        font.pixelSize: formulaArea.height/2.5
        textFormat: TextEdit.AutoText
        color: "black"
    }

    Text {
        id: fullFormulaText2
        width: formulaArea.width / 3
        height: formulaArea.height / 2
        text: "Mass(m)/Volume(v)"
        font.pixelSize: formulaArea.height/2.5
        textFormat: TextEdit.AutoText
        color: "black"
        anchors.left: fullFormulaText1.right
    }

    Text {
        id: resultInputText1
        width: fullFormulaText1.width
        height: fullFormulaText1.height
        text: " = "
        horizontalAlignment: Text.AlignRight
        font.pixelSize: formulaArea.height/2.5
        anchors.top : fullFormulaText1.bottom
        anchors.left: fullFormulaText1.left
        textFormat: TextEdit.AutoText
        color: "red"
    }

    TextInput {
        id: resultInputText2
        width: fullFormulaText2.width/1.1
        height: fullFormulaText2.height
        anchors.top : fullFormulaText2.bottom
        anchors.left: fullFormulaText2.left
        color : "red"
        font.bold: true
        font.pixelSize: formulaArea.height/2.5
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
            decimals: 3
        }
        maximumLength: 9
    }

    Rectangle {
        id : validateButton
        width: fullFormulaText2.width/2
        height: fullFormulaText2.height
        anchors {
            left : resultInputText2.right
            bottom : resultInputText2.bottom
            leftMargin: 2
        }
        color : "yellow"
        radius : 5
        border.width: 1
        border.color : "red"
        signal clicked

        Text {
            id : validateButtonText
            text : "validate"
            color : "red"
            anchors.fill : validateButton
            anchors.centerIn: validateButton
            horizontalAlignment: TextEdit.AlignHCenter
            verticalAlignment: TextEdit.AlignVCenter
            font.pixelSize: validateButtonText.height/2
        }
        MouseArea {
            id : buttonMouseArea
            property double calculatedDensity : 0.0
            property double inputDensity : 0.0
            anchors.fill: validateButton
            onClicked : {
                if(resultInputText2.text.length > 0 && calculatedWeight !== 0.0 && calculatedVolume !== 0.0) {
                    calculatedDensity = calculatedWeight/calculatedVolume
                    calculatedDensity.toPrecision(5)
                    inputDensity = resultInputText2.text
                    inputDensity.toPrecision(5)
                    if(Math.abs(inputDensity - calculatedDensity) <= 0.019)
                        densityWin.showDensityExperiment(true)
                    else
                        densityWin.showDensityExperiment(false)
                }
            }
        }
    }

    function reset() {
        resultInputText2.text = ""
    }
}
