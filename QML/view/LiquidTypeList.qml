import QtQuick 2.0

Item {
    //density is in gm/ml
    property list<Rectangle> liquidTypeList: [
        Rectangle { property string recName: "Water"
                    property string recColor :  "#006aff"
                    property double recOpacity: 0.5
                    property double recDensity: 1
        },
        Rectangle { property string recName: "Oil"
                    property string recColor :  "yellow"
                    property double recOpacity: 1
                    property double recDensity: 0.84
        },
        Rectangle { property string recName: "Honey"
                    property string recColor :  "gold"
                    property double recOpacity: 1
                    property double recDensity: 1.42
        },
        Rectangle { property string recName: "Salt Water"
                    property string recColor :  "slateblue"
                    property double recOpacity: 1
                    property double recDensity: 1.2
        },
        Rectangle { property string recName: "Mercury"
                    property string recColor :  "gray"
                    property double recOpacity: 1
                    property double recDensity: 13.6
        }
    ]

    function getName(index, defaultValue) {
        if(index < liquidTypeList.length ) {
            return liquidTypeList[index].recName
        }else{
            return defaultValue
        }
    }
    function getColor(index, defaultValue) {
        if(index < liquidTypeList.length ) {
            return liquidTypeList[index].recColor
        }else{
            return defaultValue
        }
    }
    function getOpacity(index, defaultValue) {
        if(index < liquidTypeList.length ) {
            return liquidTypeList[index].recOpacity
        }else{
            return defaultValue
        }
    }
    function getDensity(index, defaultValue) {
        if(index < liquidTypeList.length ) {
            return liquidTypeList[index].recDensity
        }else{
            return defaultValue
        }
    }
    function validIndex(index) {
        if(index < liquidTypeList.length ) {
            return true
        }else{
            return false
        }
    }

}
