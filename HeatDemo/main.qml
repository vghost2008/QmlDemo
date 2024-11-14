import QtQuick 2.7
import QtQuick.Window 2.2
import QtLocation 5.9
import QtPositioning 5.9
import MapHeatImage 1.0
import QtQuick.Controls 2.4

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Map Heat")
    /*Plugin {
        id: mapPlugin
        name: "osm"
    }*/

    Map{
        id:myMap
        anchors.fill: parent
        //plugin: mapPlugin
        zoomLevel: 8
        color: "#00000000"
        center: QtPositioning.coordinate(24,102)
        copyrightsVisible: false
        activeMapType: myMap.supportedMapTypes[1]

        /*PluginParameter {
        name: "osm.mapping.custom.host";
        value: "https://tile.thunderforest.com1/cycle/%z/%x/%y.png?apikey=<my API key here>"
        //value: "https://tile.thunderforest.com/cycle/%z/%x/%y.png"
        }*/
        /*PluginParameter {
                name: "osm.mapping.providersrepository.address";
                // name: "osm.geocoding.host"; (also didn't work)
                //value: "https://tile.thunderforest.com/transport/{z}/{x}/{y}.png?apikey=<my_api_key>" 
                value: "https://tile.thunderforest.com1/cycle/%z/%x/%y.png?apikey=b41df9be963248eeb3ebdbf258f1d43f"
               }*/
        plugin: Plugin {
            id: mapPlugin
            name: "osm"
            //PluginParameter { name: "osm.mapping.providersrepository.address"; value: "/opt/DataDisk1-21/wj/ai/work/opensource/qt-osm-map-providers1" }
            //PluginParameter { name: "osm.mapping.highdpi_tiles"; value: true }
            PluginParameter {
            name: "osm.mapping.custom.host";
            value: "https://tile.thunderforest.com/cycle/%z/%x/%y.png?apikey=b41df9be963248eeb3ebdbf258f1d43f&"
            }
        }
        onSupportedMapTypesChanged: {
        myMap.activeMapType = myMap.supportedMapTypes[myMap.supportedMapTypes.length - 1]
        console.log("Changed: "+myMap.activeMapType.name);
     }
        //activeMapType: supportedMapTypes[1]
        MapCircle {
            id:point1
            center {
                latitude: 24
                longitude: 102
            }
            radius: 5000.0
            color: 'green'
            border.width: 3
        }
        MapCircle {
            id:point2
            center {
                latitude: 24.2
                longitude: 102
            }
            radius: 5000.0
            color: 'green'
            border.width: 3
        }
        MapCircle {
            id:point3
            center {
                latitude: 24.6
                longitude: 102
            }
            radius: 5000.0
            color: 'green'
            border.width: 3
        }
        MapCircle {
            id:point4
            center {
                latitude: 24.5
                longitude: 102
            }
            radius: 5000.0
            color: 'green'
            border.width: 3
        }
        MapCircle {
            id:point5
            center {
                latitude: 24
                longitude: 102.5
            }
            radius: 5000.0
            color: 'green'
            border.width: 3
        }


        MapHeatImage{
            id:mapHeatImage
            anchors.fill: parent//MapHeatImage的尺寸必须和Map尺寸大小一致
            legendVisible: checkBoxLegend.checked//热力图颜色标识
            hideZeroPoint: checkBoxHideZero.checked//无数据处颜色是否透明
            diffraction: slider.value//热力衍射值大小
        }

    }

    Rectangle{
        id: rectangle
        anchors.right: parent.right
        width: row.width+10
        height: 60
        color: "#e6e1e1e1"
        Row {
            id:row
            x: 5
            anchors.verticalCenter: parent.verticalCenter
            Button{
                text: "绘制热力图"
                highlighted: true
                onClicked: {
                    mapHeatImage.clear()
                    setHeatPos()
                    mapHeatImage.paintHeat()
                }
            }
            CheckBox{
                id:checkBoxLegend
                text: "显示颜色标识"
                checked: true
            }
            CheckBox{
                id:checkBoxHideZero
                text:"无数据位置透明"
                checked: true
            }
            Slider{
                id:slider
                width: 80
                stepSize: 1
                to: 60
                from: 1
                value: 40

            }
        }
    }

//    Component.onCompleted: {
//        setMapOffLineType()
//    }

    function setHeatPos(){//将经纬度数据转为相对位置数据并传入MapHeatImage
        var pos1 = myMap.fromCoordinate(point1.center)
        mapHeatImage.appendListPos(pos1)
        var pos2 = myMap.fromCoordinate(point2.center)
        mapHeatImage.appendListPos(pos2)
        var pos3 = myMap.fromCoordinate(point3.center)
        mapHeatImage.appendListPos(pos3)
        var pos4 = myMap.fromCoordinate(point4.center)
        mapHeatImage.appendListPos(pos4)
        var pos5 = myMap.fromCoordinate(point5.center)
        mapHeatImage.appendListPos(pos5)
        for(var m in myMap.supportedMapTypes)
            console.log(m);
        console.log(myMap.activeMapType.name);
    }

//    function setMapOffLineType(){
//        if(myMap.activeMapType.name != "Night Transit Map"){
//            for(var a in myMap.supportedMapTypes){
//                if(myMap.supportedMapTypes[a].name === "Night Transit Map"){
//                    myMap.activeMapType = myMap.supportedMapTypes[a]
//                }
//            }
//        }
//    }
}
