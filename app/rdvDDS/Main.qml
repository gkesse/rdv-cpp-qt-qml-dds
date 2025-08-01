import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import org.QrtiDDS 1.0

ApplicationWindow {
    id: root
    title: qsTr("rdvDDS")
    minimumHeight: 300
    minimumWidth: 400

    maximumWidth: Screen.width
    maximumHeight: Screen.height
    visible: true

    property string myName : "Me"
    property variant mySettingsWindow

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem {
                text: qsTr("E&xit")
                onTriggered: Qt.quit();
            }
        }
    }

    TabBar {
        id: myTabs
        width: parent.width

        TabButton {
            text: "Message"
        }

        TabButton {
            text: "Settings"
        }
    }

    StackLayout {
        anchors.top: myTabs.bottom
        anchors.bottom: parent.bottom
        width: parent.width
        currentIndex: myTabs.currentIndex

        Item {
            id: messageTab

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10

                TextArea {
                    id: rcvMsgs
                    readOnly: true
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                TextField {
                    id: publish_message
                    text: ""
                    Layout.fillWidth: true
                    onAccepted: {
                        if (text){
                            msgHandler.writeData(root.myName + ": " + text);
                            publish_message.text = "";
                        }
                    }
                }

                Button {
                    id: publish_messageBtn
                    text: "Publish Message to DDS"
                    Layout.alignment: Qt.AlignCenter
                    leftPadding: 10
                    rightPadding: 10

                    onClicked: {
                        if (publish_message.text){
                            msgHandler.writeData(root.myName + ": " + publish_message.text);
                            publish_message.text = "";
                        }
                    }
                }

                QrtiDDShandler {
                    id: msgHandler
                    onNewRcvdDataAvailable: (data) => rcvMsgs.append(data);
                }
            }
        }

        Item {
            id: settingsTab

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10

                TextField {
                    id: myName
                    text: root.myName
                    Layout.fillWidth: true
                    rightPadding: 10
                    leftPadding: 10

                    onAccepted: {
                        if (text){
                            root.myName = text;
                            messageDialog.show(qsTr("Name successfully changed"))
                        }
                    }
                }

                Button {
                    id: setName
                    text: "Set Chat Name"
                    Layout.alignment: Qt.AlignCenter
                    leftPadding: 10
                    rightPadding: 10

                    onClicked: {
                        if (myName.text){
                            root.myName = myName.text
                            messageDialog.show(qsTr("Name successfully changed"))
                        }
                    }
                }

                Item {
                    Layout.fillHeight: true
                }

                MessageDialog {
                    id: messageDialog
                    title: qsTr("Successful")

                    function show(caption) {
                        messageDialog.text = caption;
                        messageDialog.open();
                    }
                }
            }
        }
    }
}
