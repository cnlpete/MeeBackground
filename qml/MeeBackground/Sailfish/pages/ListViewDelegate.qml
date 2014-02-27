//Copyright Hauke Schade, 2013
//
//This file is part of MeeBackground.
//
//MeeBackground is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the
//Free Software Foundation, either version 2 of the License, or (at your option) any later version.
//MeeBackground is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
//You should have received a copy of the GNU General Public License along with MeeBackground (on a Maemo/Meego system there is a copy
//in /usr/share/common-licenses. If not, see http://www.gnu.org/licenses/.

// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0
import Sailfish.Silica 1.0

ListItem {
    id: root

    signal clicked

    width: parent.width
    height: Theme.itemSizeExtraLarge
    contentHeight: Theme.itemSizeExtraLarge

    Image {
        clip: true
        anchors.fill: parent
        anchors.margins: mouseArea.pressed ? 10 : 0
        fillMode: Image.PreserveAspectCrop

        Behavior on anchors.margins {
            PropertyAnimation {
                duration: 100
            }
        }

        source: thumb
        asynchronous: true

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                root.clicked()
//                pageStack.push("DesktopprListView.qml")
                previewPage.set(title, username, id, url, thumb, source)
                pageStack.push(previewPage)
            }
        }

        Rectangle {
            anchors {
                right: parent.right
                bottom: parent.bottom
                margins: -10
            }
            width: credits.width + 20
            height: credits.height + 20

            color: '#80000000'
            radius: 10

            Label {
                id: credits
                anchors {
                    right: parent.right
                    bottom: parent.bottom
                    margins: 15
                }
                font.pixelSize: Theme.fontSizeSmall
                text: username !== '' ?
                          (qsTr("%1 by %2").arg(title).arg(username)) :
                          title

            }
        }

        BusyIndicator {
            anchors.centerIn: parent
            visible: parent.status === Image.Loading
            running: visible
        }
    }
}
