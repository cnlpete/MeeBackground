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

Page {
    id: aboutPage
    property alias iconSource: icon.source
    property alias title: title.text
    property alias slogan: slogan.text
    property alias text: content.text


    tools: ToolBarLayout {
        ToolIcon {
            iconId: 'toolbar-back'
            onClicked: pageStack.pop()
        }
    }

    Flickable {
        anchors.fill: parent
        contentHeight: aboutContainer.height + 10
        contentWidth: aboutContainer.width

        Item {
            id: aboutContainer
            width: aboutPage.width
            height: aboutColumn.height

            Column {
                id: aboutColumn

                anchors {
                    left: parent.left
                    top: parent.top
                    right: parent.right
                    margins: 10
                }

                spacing: 10

                Image {
                    id: icon
                    source: ''
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Label {
                    id: title
                    text: 'Name 0.0.0'
                    font.pixelSize: 40
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Label {
                    id: slogan
                    text: 'Slogan !'
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Item {
                    width: 1
                    height: 50
                }

                Label {
                    id: content
                    text: ''
                    width: aboutPage.width
                    wrapMode: Text.WordWrap
                }
            }
        }
    }

    //Component.onCompleted: theme.inverted = true
}
