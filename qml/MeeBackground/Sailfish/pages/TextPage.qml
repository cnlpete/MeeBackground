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

Page {
    property alias text: content.text
    property alias title: header.title
    property alias iconSource: icon.source

    anchors.margins: Theme.paddingMedium

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: aboutColumn.height + 10
        contentWidth: parent.width

        Column {
            id: aboutColumn
            width: parent.width
            anchors.margins: Theme.paddingMedium

            spacing: Theme.paddingSmall

            PageHeader {
                id: header
            }

            Image {
                id: icon
                visible: source != ""
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Label {
                id: content
                width: parent.width - 2 * Theme.paddingMedium
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
                horizontalAlignment: Text.AlignJustify
                onLinkActivated : Qt.openUrlExternally(link)
            }
        }
    }
}
