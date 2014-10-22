import QtQuick 2.2
import QtQuick.Controls 1.1
import "QML/view"

ApplicationWindow {
    visible: true
    width: 900
    height: 700
    minimumHeight: 700
    minimumWidth: 900
    maximumHeight: 700
    maximumWidth: 900

    title: qsTr("Density Problem")

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    Main {
        anchors.fill: parent
    }
}
