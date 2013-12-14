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
import QtQuick 1.1
import com.nokia.meego 1.0
import "../Models"

Page {
    id: root
    tools: ToolBarLayout {
        id: commonTools
        visible: true
        ToolIcon {
            platformIconId: 'toolbar-back'
            onClicked: pageStack.pop()
        }
        ToolIcon {
            platformIconId: "toolbar-view-menu"
            anchors.right: (parent === undefined) ? undefined : parent.right
            onClicked: (myMenu.status === DialogStatus.Closed) ? myMenu.open() : myMenu.close()
        }
    }

    DesktopprModel {
        id: desktopprmodel
    }

    BusyIndicator {
        anchors.centerIn: parent
        platformStyle: BusyIndicatorStyle { size: "large" }
        running: visible
        visible: desktopprmodel.running
    }

    PageHeader {
        id: pageHeader
        text: qsTr("DesktopPr")
    }

    Item {
        anchors {
            top: pageHeader.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        ListView {
            id: listView
            property int imageItemHeight: 150
            width: parent.width

            footer: Item {
                height: listView.imageItemHeight
                width: parent.width

                Button {
                    anchors.centerIn: parent
                    text: qsTr('More')
                    onClicked: desktopprmodel.load()
                    enabled: !desktopprmodel.running
                    width: parent.width * .5
                }
            }

            anchors.fill: parent
            model: desktopprmodel
            delegate: ListViewDelegate { }
        }

        ScrollDecorator {
            flickableItem: listView
        }
    }

    Component.onCompleted: {
        desktopprmodel.load()
    }
}
