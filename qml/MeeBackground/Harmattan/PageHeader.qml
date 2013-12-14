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

import QtQuick 1.1
import com.nokia.meego 1.0
import com.nokia.extras 1.1

Item {
    id: root

    property alias text: mainText.text
    property bool hasUpdateAction: false
    property bool busy: false
    property int maxheight: inPortrait ? 72 : 56

    signal updateActionActivated()

    height: Math.max(root.maxheight, mainText.height)
    width: parent.width
    visible: text !== ""
    z: 100

    Image {
        id: background
        anchors.fill: parent
        source: "image://theme/color15-meegotouch-view-header-fixed"
        sourceSize.width: parent.width
        sourceSize.height: parent.height
    }

    Label {
        id: mainText
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: updateAction.left
            margins: 8
        }
        font.pixelSize: 30
        color: "white"
        elide: Text.ElideRight
        text: "title"
        maximumLineCount: 1
    }


    Item {
        id: updateAction
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 8
        width: updateIcon.width
        height: updateIcon.height
        visible: hasUpdateAction || busy

        Image {
            id: updateIcon
            source: "image://theme/icon-m-toolbar-refresh"
            visible: hasUpdateAction && !busy
        }

        BusyIndicator {
            id: busyIndicator
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            visible: busy
            running: visible
            platformStyle: BusyIndicatorStyle { size: 'medium' }
        }

        MouseArea {
            enabled: !busy && hasUpdateAction
            anchors.fill: parent
            onClicked: {
                root.updateActionActivated()
            }
        }
    }
}
