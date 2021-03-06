import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

Rectangle {
    id: pwdField
    width: settings.width-buttonWidth - button1.anchors.leftMargin * 2
    height: window1.height
    color: "#00000000"
    property int buttonWidthKeyboard: window1.width/9.0
    property int buttonHeightKeyboard: window1.height/9.0
    property int buttonMargin:20
    property string keyBoardRes :"";
    property string password: "12345";
    property real textHeight: window1.height/6
    function setRes(arg){
        keyBoardRes = arg;
        textField.text = Qt.binding(function(){return keyBoardRes;})
    }
    function clearText(){
        textField.text ="";
        keyBoardRes ="";
    }

    function buttonClick(arg){
        if(textField.text == "Ошибка"){
            textField.text="";
        }

        if(arg == "<-"){
            keyBoardRes = keyBoardRes.toString().substring(0,keyBoardRes.toString().length-1);
            if(keyBoardRes == "" || keyBoardRes == "-")
                keyBoardRes = "";
        }
        else if(keyBoardRes.length>4){
            return;
        }

        else if(arg == "+/-"){
            keyBoardRes *= -1;
        } else if(arg == "+0.1"){
            keyBoardRes = Math.round(((parseFloat(keyBoardRes) + 0.1)*10))/10;
        }
        else if(arg == "-0.1"){
            keyBoardRes = Math.round(((parseFloat(keyBoardRes) - 0.1)*10))/10;
        } else {
            if(keyBoardRes == "0" && arg != ".")
                keyBoardRes = "";
            keyBoardRes += arg;
        }

        if(keyBoardRes.toString().indexOf(".") > 0){
            keyBoardRes = keyBoardRes.toString().substring(0,keyBoardRes.toString().indexOf(".")+2);
        }
        textField.text = keyBoardRes;
    }


    function revert(arg){
        if(arg == password){
            keyBoardRes ="";
            textField.text ="";
            compass.revert();
        }
        else{
            keyBoardRes ="";
            textField.text ="Ошибка";
        }
    }

    Component{
        id: keyboardButtonStyle

        ButtonStyle{
            label: Text {
                renderType: Text.NativeRendering
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family:  helvetica.name
                font.pointSize: buttonFontSize
                color: window1.dayNight === false ? "#7fff00": "black"
                text: control.text
              }
            background: Rectangle {
                border.width: control.pressed ? 5:1
                border.color: "#888"
                radius: 4
                color: dayNight === false ? "black" : "white"
            }
        }
    }
    Label{
        id:labelPass
        text: qsTr("Введите пароль")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: textField.top
        anchors.bottomMargin: buttonMargin

        font.pixelSize: parent.width/ 20
        color: window1.dayNight === false ? "#7fff00": "black"
         font.family:helvetica.name
    }
    TextField {
        id: textField

        width: buttonWidthKeyboard*2 + buttonMargin
        height: buttonHeightKeyboard
        z: 1
        placeholderText: qsTr("")
        text: keyBoardRes.toString()
        anchors.top: parent.top
        anchors.topMargin: parent.height /5.5
        anchors.left: parent.left
        anchors.leftMargin: parent.width /7
//        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: textField.height / 1.5
        font.family:helvetica.name
        style:
            TextFieldStyle{
            textColor:window1.dayNight === false ?"#7fff00" : "black"
            background: Rectangle{
                color: dayNight === false ? "black" : "white"
                border.color: "#888"
                radius: 4

            }
        }
    }
    Button{
        id: buttonDel
        width: buttonWidthKeyboard
        height: buttonHeightKeyboard
        text: qsTr("<-")
        anchors.left: textField.right
        anchors.leftMargin: buttonMargin
        anchors.top: textField.top
        anchors.topMargin: 0
        style: keyboardButtonStyle
        onClicked: {
            compass.sound()
            buttonClick(text)
        }
    }
    Button{
        id: button0
        anchors.left: button7.left
        anchors.top: button8.bottom
        width: buttonWidthKeyboard
        height: buttonHeightKeyboard
        text: qsTr("0")
        anchors.leftMargin: 0
        anchors.topMargin: buttonMargin
        //anchors.right: buttonCancel.left
        anchors.rightMargin: buttonMargin
        style: keyboardButtonStyle
        onClicked: {
            compass.sound()
            buttonClick(text)
        }
    }
    Button{
        id: button1
        anchors.left: textField.left
        anchors.top: textField.bottom
        width: buttonWidthKeyboard
        height: buttonHeightKeyboard
        text: qsTr("1")
        anchors.leftMargin: 0
        anchors.topMargin: buttonMargin
        style: keyboardButtonStyle
        onClicked: {
            compass.sound()
            buttonClick(text)
        }
    }
    Button{
        id: button2
        anchors.top: textField.bottom
        width: buttonWidthKeyboard
        height: buttonHeightKeyboard
        text: qsTr("2")
        anchors.left: button1.right
        anchors.leftMargin: buttonMargin
        anchors.topMargin: buttonMargin
        style: keyboardButtonStyle
        onClicked: {
            compass.sound()
            buttonClick(text)
        }
    }
    Button{
        id: button3
        anchors.left: button2.right
        anchors.top: textField.bottom
        width: buttonWidthKeyboard
        height: buttonHeightKeyboard
        text: qsTr("3")
        anchors.leftMargin: buttonMargin
        anchors.topMargin: buttonMargin
        style: keyboardButtonStyle
        onClicked: {
            compass.sound()
            buttonClick(text)
        }
    }
    Button{
        id: button4
        anchors.top: button1.bottom
        width: buttonWidthKeyboard
        height: buttonHeightKeyboard
        text: qsTr("4")
        anchors.topMargin: buttonMargin
        anchors.rightMargin: buttonMargin
        anchors.right: button2.left
        style: keyboardButtonStyle
        onClicked: {
            compass.sound()
            buttonClick(text)
        }
    }
    Button{
        id: button5
        anchors.left: button4.right
        anchors.top: button2.bottom
        width: buttonWidthKeyboard
        height: buttonHeightKeyboard
        text: qsTr("5")
        anchors.right: button6.left
        anchors.rightMargin: buttonMargin
        anchors.leftMargin: buttonMargin
        anchors.topMargin: buttonMargin
        style: keyboardButtonStyle
        onClicked: {
            compass.sound()
            buttonClick(text)
        }
    }
    Button{
        id: button6
        anchors.left: button2.right
        anchors.top: button3.bottom
        width: buttonWidthKeyboard
        height: buttonHeightKeyboard
        text: qsTr("6")
        anchors.topMargin: buttonMargin
        anchors.leftMargin: buttonMargin
        style: keyboardButtonStyle
        onClicked: {
            compass.sound()
            buttonClick(text)
        }
    }
    Button{
        id: button7
        anchors.leftMargin: buttonMargin
        anchors.top: button4.bottom
        width: buttonWidthKeyboard
        height: buttonHeightKeyboard
        text: qsTr("7")
        anchors.rightMargin: buttonMargin
        anchors.right: button2.left
        anchors.topMargin: buttonMargin
        style: keyboardButtonStyle
        onClicked: {
            compass.sound()
            buttonClick(text)
        }
    }
    Button{
        id: button8
        anchors.left: button7.right
        anchors.top: button5.bottom
        width: buttonWidthKeyboard
        height: buttonHeightKeyboard
        text: qsTr("8")
        anchors.right: button9.left
        anchors.rightMargin: buttonMargin
        anchors.leftMargin: buttonMargin
        anchors.topMargin: buttonMargin
        style: keyboardButtonStyle
        onClicked: {
            compass.sound()
            buttonClick(text)
        }
    }
    Button{
        id: button9
        anchors.left: button2.right
        anchors.top: button6.bottom
        width: buttonWidthKeyboard
        height: buttonHeightKeyboard
        text: qsTr("9")
        anchors.leftMargin: buttonMargin
        anchors.topMargin: buttonMargin
        style: keyboardButtonStyle
        onClicked: {
            compass.sound()
            buttonClick(text)
        }
    }
    Button{
        id: buttonOK
        anchors.top: button8.bottom
        width: buttonWidthKeyboard*2+ buttonMargin
        height: buttonHeightKeyboard
        text: qsTr(" Ввод")
        anchors.left: button0.right
        anchors.leftMargin: 19
        anchors.topMargin: 20
        style: ButtonStyle{
            label: Text {
                renderType: Text.NativeRendering
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family:  helvetica.name
                font.pointSize: height/ 3.0
                color: window1.dayNight === false ? "#7fff00": "black"
                text: control.text
              }
            background: Rectangle {
                border.width: control.pressed ? 5:1
                border.color: "#888"
                radius: 4
                color: dayNight === false ? "black" : "white"
            }
        }
        onClicked:{
            compass.sound()
            revert(keyBoardRes)

        }
    }
//    Button{
//        id: buttonCancel
//        anchors.left: button2.right
//        anchors.top: button9.bottom
//        width: buttonWidthKeyboard
//        height: buttonHeightKeyboard
//        text: qsTr("Отмена")
//        anchors.leftMargin: buttonMargin
//        anchors.topMargin: buttonMargin
//        style: keyboardButtonStyle
//        onClicked: {
//            keyBoardRes =""
//            passDialClose.start()
//            textField.text = keyBoardRes
//            compass.sound()
//        }
//    }

}
