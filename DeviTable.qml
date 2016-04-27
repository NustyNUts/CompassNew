import QtQuick 2.0

import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1


Rectangle {
    id: deviTable
    width: settings.width-buttonWidth - button1.anchors.leftMargin * 2
    height: window1.height
    color: "#00000000"
    property int elementHeight: height / 8
    property int elementWidht: width / 7
    property bool stepTable: true //10-true,15-false
    property bool degaus: false //true -on, false-off
    function setDev(){
        tableModel.clear()
        if(stepTable == true)
            for(var i = 0;i<36;i++){
                if(degaus === true)
                    tableModel.append({"course":i*10,"corr":deviationDG10[i]})
                else
                    tableModel.append({"course":i*10,"corr":deviation10[i]})
            }
        else
            for(i = 0;i<24;i++){
                if(degaus)
                    tableModel.append({"course":i*15,"corr":deviationDG15[i]})
                else
                    tableModel.append({"course":i*15,"corr":deviation15[i]})
            }

    }

    Component{
        id:coefStyle

        ButtonStyle{
            label: Text {
                renderType: Text.NativeRendering
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: "Helvetica"
                font.pointSize: buttonFontSize
                color: window1.dayNight === false ?  "#7fff00": "black"
                text: control.text
              }

            background: Rectangle {
                border.color: "#888"
                radius: 4
                color: dayNight === false ? "black" : "white"
            }
        }
    }
    Button {
        id: butStepTable
        text: stepTable === true ? "10" : "15"
        height: elementHeight
        width: elementWidht
        anchors.left: parent.left
        anchors.leftMargin: parent.width / 6
        anchors.top: parent.top
        anchors.topMargin: parent.height/7
        style: ButtonStyle {
            label: Text {
                renderType: Text.NativeRendering
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: "Helvetica"
                font.pointSize: buttonFontSize
                color: window1.dayNight === false ?  "#7fff00": "black"
                text: control.text
            }
            background: Rectangle {
                id:butStepTableBack
                implicitWidth: 100
                implicitHeight: 25
                border.width: control.pressed ? 5:1
                border.color: "#888"
                color: dayNight === false ? "black" : "white"
                radius: 4
            }
        }
        onClicked: {
            stepTable = !stepTable
            setDev()
        }
    }

    Button {
        id: butDegaus
        text: degaus === false? "РУ ВЫКЛ":"РУ ВКЛ"
        height: elementHeight
        width: elementWidht * 4
        anchors.top: butStepTable.top
        anchors.topMargin: 0
        anchors.left: butStepTable.right
        anchors.leftMargin: 0
        style: ButtonStyle {
            label: Text {
                renderType: Text.NativeRendering
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: "Helvetica"
                font.pointSize: buttonFontSize
                color: window1.dayNight === false ?  degaus === true? "black" : "#7fff00": "black"
                text: control.text
            }
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 25
                border.width: control.pressed ? 5:1
                border.color: "#888"
                radius: 4
                color: degaus === true ? "#42e73a":window1.dayNight === false ? "black" : "white"

            }
        }
        onClicked: {
            degaus = !degaus
            setDev()
        }
    }
    Button {
        id: deviA
        text:degaus === false ? "A="+devCoef[0] :"A="+devCoefDG[0]
        height: elementHeight
        anchors.left: butStepTable.left
        anchors.leftMargin: 0
        anchors.top: butStepTable.bottom
        anchors.topMargin: 0
        width: elementWidht
        style: coefStyle
    }
    Button {
        id: deviB
        text:degaus === false ? "B="+devCoef[1] :"B="+devCoefDG[1]
        height: elementHeight
        width: elementWidht
        anchors.top: deviA.bottom
        anchors.topMargin: 0
        anchors.left: butStepTable.left
        anchors.leftMargin: 0
        style: coefStyle
    }
    Button {
        id: deviC
        text:degaus === false ? "C="+devCoef[2] :"C="+devCoefDG[2]
        height: elementHeight
        width: elementWidht
        anchors.top: deviB.bottom
        anchors.topMargin: 0
        anchors.left: butStepTable.left
        anchors.leftMargin: 0
        style: coefStyle
    }
    Button {
        id: deviD
        text:degaus === false ? "D="+devCoef[3] :"D="+devCoefDG[3]
        height: elementHeight
        width: elementWidht
        anchors.top: deviC.bottom
        anchors.topMargin: 0
        anchors.left: butStepTable.left
        anchors.leftMargin: 0
        style: coefStyle
    }
    Button {
        id: deviE
        text: degaus === false ? "E="+devCoef[4] :"E="+devCoefDG[4]
        height: elementHeight
        width: elementWidht
        anchors.top: deviD.bottom
        anchors.topMargin: 0
        anchors.left: butStepTable.left
        anchors.leftMargin: 0
        style: coefStyle
    }

        TableView{
            id: table
            width: elementWidht*4
            height:elementHeight * 5
            anchors.left: butStepTable.right
            anchors.leftMargin: 0
            anchors.top: butStepTable.bottom
            style: TableViewStyle{
                backgroundColor:dayNight === false ? "black" : "white"
                rowDelegate :Rectangle{
                    height: elementHeight

                }
                headerDelegate:Rectangle{
                    border.width: 1
                    border.color: dayNight === false ? "white" : "black"
                    width: elementWidht
                    height:elementHeight
                    color: dayNight === false ? "black" : "white"
                    Text{
                        anchors.fill: parent
                        text: styleData.value
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pointSize: height/4
                        color:window1.dayNight === false ?  "#7fff00": "black"
                    }
                }

                itemDelegate: Rectangle{

                    border.width: 1
                    border.color: dayNight === false ? "white" : "black"
                    color: dayNight === false ? "black" : "white"
                    Text{
                        anchors.fill: parent
                        text: styleData.value !== undefined  ? styleData.value : ""
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pointSize: height/3
                        color:window1.dayNight === false ?  "#7fff00": "black"
                    }
                }
            }

            TableViewColumn {
                        id: courseColumn
                        title: "КK"
                        role: "course"


                        movable: false
                        resizable: false
                        width: table.width/2-1

                    }
            TableViewColumn {
                        id: dataColumn
                        title: "поправка"
                        role: "corr"
                        movable: false
                        resizable: false
                        width: table.width/2-1
                    }
            model:tableModel
        }



    ListModel{
        id:tableModel
        Component.onCompleted: {
            setDev();
        }
    }


}
