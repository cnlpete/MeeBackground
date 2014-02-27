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
        visible: favoritesModel.running
    }

    SilicaListView {
        id: listView

        PullDownMenu {
            MenuItem {
                text: qsTr('About MeeBackground')
                onClicked: pushAbout()
            }
            MenuItem {
                text: qsTr('Add favorites')
                onClicked: pageStack.push("DesktopprListView.qml")
            }
        }
        ViewPlaceholder {
            enabled: listView.count == 0
            text: qsTr("No favorites yet. Add some")
        }

        anchors.fill: parent
        header: PageHeader {
            width: listView.width
            title: qsTr("Favorites")
        }

        model: favoritesModel
        delegate: ListViewDelegate {
            onClicked: favoritesModel.selectedIndex = index
        }
    }

    ScrollDecorator {
        flickable: listView
    }
}
