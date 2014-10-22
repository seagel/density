import QtQuick 2.0

Item {

        property list<Rectangle> objPropertiesList: [
            Rectangle { property string imgSource: "images/iron-ball.png";
                        property string imgName:  "Iron Ball";
                        property double weight: 100.00
                        property double density: 7.86
            },
            Rectangle { property string imgSource: "images/golf-ball.png";
                        property string imgName:  "Golf Ball";
                        property double weight: 40.96
                        property double density: 1.15
            },
            Rectangle { property string imgSource: "images/cotton-ball.png";
                        property string imgName:  "Cotton Ball";
                        property double weight: 70.00
                        property double density: 1.54
            },
            Rectangle { property string imgSource: "images/pingpong-ball.png";
                        property string imgName:  "Pingpong Ball";
                        property double weight: 2.41
                        property double density: 0.1
            },
            Rectangle { property string imgSource: "images/gold-nugget.png";
                        property string imgName:  "Gold Nugget";
                        property double weight: 500.00
                        property double density: 19.30
            },
            Rectangle { property string imgSource: "images/egg.png";
                        property string imgName:  "Egg";
                        property double weight: 58
                        property double density: 1.1
            },
            Rectangle { property string imgSource: "images/wooden-block.png";
                        property string imgName:  "Wooden Block";
                        property double weight: 45.00
                        property double density: 0.8
            },
            Rectangle { property string imgSource: "images/apple-slice.png";
                        property string imgName:  "Apple Slice";
                        property double weight: 50.00
                        property double density: 0.86
            },
            Rectangle { property string imgSource: "images/golden-crown.png";
                        property string imgName:  "Golden Crown";
                        property double weight: 110.00
                        property double density: 11
            },
            Rectangle { property string imgSource: "images/coin.png";
                        property string imgName:  "coin";
                        property double weight: 2.5
                        property double density: 7.18
            }
        ]

        function getSource(index, defaultValue) {
            if(index < objPropertiesList.length ) {
                return objPropertiesList[index].imgSource
            }else{
                return defaultValue
            }
        }

        function getName(index, defaultValue) {
            if(index < objPropertiesList.length ) {
                return objPropertiesList[index].imgName
            }else{
                return defaultValue
            }
        }

        function getWeight(index, defaultValue) {
            if(index < objPropertiesList.length ) {
                return objPropertiesList[index].weight
            }else{
                return defaultValue
            }
        }

        function getDensity(index, defaultValue) {
            if(index < objPropertiesList.length ) {
                return objPropertiesList[index].density
            }else{
                return defaultValue
            }
        }

        function validIndex(index) {
            if(index < objPropertiesList.length ) {
                return true
            }else{
                return false
            }
        }

    }

