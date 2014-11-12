import QtQuick 2.0
import QtQuick.Controls 1.2

Item {
    id : resultsTable

    ListModel {
       id: resultsModel
    }

    TableView {
       anchors.fill : resultsTable

       TableViewColumn{ role: "objectName"  ; title: "Object Name" ; width: resultsTable.width/4; }
       TableViewColumn{ role: "objectDensity"  ; title: "ρ(Object)" ; width: resultsTable.width/6; }
       TableViewColumn{ role: "liquidType" ; title: "Liquid Type" ; width: resultsTable.width/5 }
       TableViewColumn{ role: "liquidDensity" ; title: "ρ(Liquid)" ; width: resultsTable.width/6 }
       TableViewColumn{
           role: "observation"
           title: "Observation"
           width: resultsTable.width/4
       }

       model: resultsModel
    }

    function addRow(objectName, objectDensity, liquidType, liquidDensity, observation) {
        for( var index = 0 ;  index < resultsModel.count; index++ ) {
            var row = resultsModel.get(index)
            if(row.objectName === objectName && row.liquidType === liquidType && row.observation === observation) {
                return
            }
        }

        resultsModel.append({ objectName: objectName , objectDensity: objectDensity, liquidType: liquidType, liquidDensity : liquidDensity, observation: observation})
    }

    function reset() {

    }

}
