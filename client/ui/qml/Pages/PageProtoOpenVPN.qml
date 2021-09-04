import QtQuick 2.12
import QtQuick.Controls 2.12
import "./"
import "../Controls"
import "../Config"

Item {
    id: root
    enabled: UiLogic.pageProtoOpenvpnEnabled
    ImageButtonType {
        id: back
        x: 10
        y: 10
        width: 26
        height: 20
        icon.source: "qrc:/images/arrow_left.png"
        onClicked: {
            UiLogic.closePage()
        }
    }
    Item {
        x: 0
        y: 40
        width: 380
        height: 600
        enabled: UiLogic.widgetProtoOpenvpnEnabled
        CheckBoxType {
            x: 30
            y: 280
            width: 321
            height: 21
            text: qsTr("Auto-negotiate encryption")
            checked: UiLogic.checkBoxProtoOpenvpnAutoEncryptionChecked
            onCheckedChanged: {
                UiLogic.checkBoxProtoOpenvpnAutoEncryptionChecked = checked
            }
            onClicked: {
                UiLogic.checkBoxProtoOpenvpnAutoEncryptionClicked()
            }
        }
        CheckBoxType {
            x: 30
            y: 430
            width: 321
            height: 21
            text: qsTr("Block DNS requests outside of VPN")
            checked: UiLogic.checkBoxProtoOpenvpnBlockDnsChecked
            onCheckedChanged: {
                UiLogic.checkBoxProtoOpenvpnBlockDnsChecked = checked
            }
        }
        CheckBoxType {
            x: 30
            y: 390
            width: 321
            height: 21
            text: qsTr("Enable TLS auth")
            checked: UiLogic.checkBoxProtoOpenvpnTlsAuthChecked
            onCheckedChanged: {
                UiLogic.checkBoxProtoOpenvpnTlsAuthChecked = checked
            }

        }
        ComboBoxType {
            x: 30
            y: 340
            width: 151
            height: 31
            model: [
                qsTr("AES-256-GCM"),
                qsTr("AES-192-GCM"),
                qsTr("AES-128-GCM"),
                qsTr("AES-256-CBC"),
                qsTr("AES-192-CBC"),
                qsTr("AES-128-CBC"),
                qsTr("ChaCha20-Poly1305"),
                qsTr("ARIA-256-CBC"),
                qsTr("CAMELLIA-256-CBC"),
                qsTr("none")
            ]
            currentIndex: {
                for (let i = 0; i < model.length; ++i) {
                    if (UiLogic.comboBoxProtoOpenvpnCipherText === model[i]) {
                        return i
                    }
                }
                return -1
            }
            onCurrentTextChanged: {
                UiLogic.comboBoxProtoOpenvpnCipherText = currentText
            }
            enabled: UiLogic.comboBoxProtoOpenvpnCipherEnabled
        }
        ComboBoxType {
            x: 200
            y: 340
            width: 151
            height: 31
            model: [
                qsTr("SHA512"),
                qsTr("SHA384"),
                qsTr("SHA256"),
                qsTr("SHA3-512"),
                qsTr("SHA3-384"),
                qsTr("SHA3-256"),
                qsTr("whirlpool"),
                qsTr("BLAKE2b512"),
                qsTr("BLAKE2s256"),
                qsTr("SHA1")
            ]
            currentIndex: {
                for (let i = 0; i < model.length; ++i) {
                    if (UiLogic.comboBoxProtoOpenvpnHashText === model[i]) {
                        return i
                    }
                }
                return -1
            }
            onCurrentTextChanged: {
                UiLogic.comboBoxProtoOpenvpnHashText = currentText
            }
            enabled: UiLogic.comboBoxProtoOpenvpnHashEnabled
        }
        Rectangle {
            x: 30
            y: 140
            width: 321
            height: 71
            border.width: 1
            border.color: "lightgray"
            radius: 2
            RadioButtonType {
                x: 10
                y: 40
                width: 171
                height: 19
                text: qsTr("TCP")
                enabled: UiLogic.radioButtonProtoOpenvpnTcpEnabled
                checked: UiLogic.radioButtonProtoOpenvpnTcpChecked
                onCheckedChanged: {
                    UiLogic.radioButtonProtoOpenvpnTcpChecked = checked
                }
            }
            RadioButtonType {
                x: 10
                y: 10
                width: 171
                height: 19
                text: qsTr("UDP")
                checked: UiLogic.radioButtonProtoOpenvpnUdpChecked
                onCheckedChanged: {
                    UiLogic.radioButtonProtoOpenvpnUdpChecked = checked
                }
                enabled: UiLogic.radioButtonProtoOpenvpnUdpEnabled
            }
        }
        LabelType {
            x: 30
            y: 110
            width: 151
            height: 21
            text: qsTr("Network protocol")
        }
        LabelType {
            x: 30
            y: 230
            width: 151
            height: 31
            text: qsTr("Port")
        }
        Text {
            font.family: "Lato"
            font.styleName: "normal"
            font.pixelSize: 24
            color: "#100A44"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: qsTr("OpenVPN Settings")
            x: 10
            y: 0
            width: 340
            height: 30
        }
        LabelType {
            x: 200
            y: 310
            width: 151
            height: 21
            text: qsTr("Hash")
        }
        LabelType {
            x: 30
            y: 40
            width: 291
            height: 21
            text: qsTr("VPN Addresses Subnet")
        }
        LabelType {
            x: 30
            y: 310
            width: 151
            height: 21
            text: qsTr("Cipher")
        }
        LabelType {
            id: label_proto_openvpn_info
            x: 30
            y: 550
            width: 321
            height: 41
            visible: UiLogic.labelProtoOpenvpnInfoVisible
            text: UiLogic.labelProtoOpenvpnInfoText
        }
        TextFieldType {
            id: lineEdit_proto_openvpn_port
            x: 200
            y: 230
            width: 151
            height: 31
            text: UiLogic.lineEditProtoOpenvpnPortText
            onEditingFinished: {
                UiLogic.lineEditProtoOpenvpnPortText = text
            }
            enabled: UiLogic.lineEditProtoOpenvpnPortEnabled
        }
        TextFieldType {
            id: lineEdit_proto_openvpn_subnet
            x: 30
            y: 65
            width: 321
            height: 31
            text: UiLogic.lineEditProtoOpenvpnSubnetText
            onEditingFinished: {
                UiLogic.lineEditProtoOpenvpnSubnetText = text
            }
        }
        ProgressBar {
            id: progressBar_proto_openvpn_reset
            anchors.horizontalCenter: parent.horizontalCenter
            y: 500
            width: 321
            height: 40
            from: 0
            to: UiLogic.progressBarProtoOpenvpnResetMaximium
            value: UiLogic.progressBarProtoOpenvpnResetValue
            visible: UiLogic.progressBarProtoOpenvpnResetVisible
            background: Rectangle {
                implicitWidth: parent.width
                implicitHeight: parent.height
                color: "#100A44"
                radius: 4
            }

            contentItem: Item {
                implicitWidth: parent.width
                implicitHeight: parent.height
                Rectangle {
                    width: progressBar_proto_openvpn_reset.visualPosition * parent.width
                    height: parent.height
                    radius: 4
                    color: Qt.rgba(255, 255, 255, 0.15);
                }
            }
        }
        BlueButtonType {
            anchors.horizontalCenter: parent.horizontalCenter
            y: 500
            width: 321
            height: 40
            text: qsTr("Save and restart VPN")
            visible: UiLogic.pushButtonProtoOpenvpnSaveVisible
            onClicked: {
                UiLogic.onPushButtonProtoOpenvpnSaveClicked()
            }
        }
    }
}