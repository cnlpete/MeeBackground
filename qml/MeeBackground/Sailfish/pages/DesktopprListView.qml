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

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../../Models"

Page {
    id: root

    BusyIndicator {
        anchors.centerIn: parent
        size: BusyIndicatorSize.Large
        running: visible
        visible: desktopprmodel.running
        z: 100
    }

    DesktopprModel {
        id: desktopprmodel
        Component.onCompleted: {
            desktopprmodel.load()
        }
    }

    SilicaListView {
        id: listView

        PullDownMenu {
            MenuItem {
                text: qsTr('About MeeBackground')
                onClicked: pushAbout()
            }
        }

        anchors.fill: parent
        header: PageHeader {
            width: listView.width
            title: qsTr("DesktopPr")
        }
        footer: Item {
            height: Theme.itemSizeMedium
            width: parent.width

            Button {
                anchors.centerIn: parent
                text: qsTr('More')
                onClicked: desktopprmodel.load()
                enabled: !desktopprmodel.running
                width: parent.width * .5
            }
        }

        model: desktopprmodel
        delegate: ListViewDelegate {
            onClicked: desktopprmodel.selectedIndex = index
        }

        ScrollDecorator {
            flickable: listView
        }
    }
}
