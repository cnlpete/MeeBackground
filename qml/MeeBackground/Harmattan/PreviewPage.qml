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
    id: previewPage
    orientationLock: PageOrientation.LockPortrait

    tools: ToolBarLayout {
        ToolIcon {
            platformIconId: 'toolbar-back'
            onClicked: pageStack.pop()
        }
        ToolIcon {
            platformIconId: 'toolbar-share'
            onClicked: QMLUtils.shareUrl(url, title);
        }
        ToolIcon {
            platformIconId: previewPage.favorite ? 'toolbar-favorite-mark' : 'toolbar-favorite-unmark'
            enabled: img.status == Image.Ready
            onClicked: {
                if (previewPage.favorite) {
                    if (favoritesModel.removeFavorite(id, source))
                        previewPage.favorite = false
                }
                else {
                    if (favoritesModel.addFavorite(id, title, username, source, img))
                        previewPage.favorite = true
                }
            }
        }
        ToolIcon {
            platformIconId: "toolbar-view-menu"
            anchors.right: (parent === undefined) ? undefined : parent.right
            onClicked: (myMenu.status === DialogStatus.Closed) ? myMenu.open() : myMenu.close()
        }
    }

    property string id
    property string title
    property string username
    property string url
    property string thumb
    property string source
    property bool favorite: false

    function set(title, username, id, url, thumb, source) {
        previewPage.title = title
        previewPage.username = username
        previewPage.id = id
        previewPage.url = url
        previewPage.thumb = thumb
        previewPage.source = source
        previewPage.favorite = favoritesModel.isFavorite(id, source)
    }

    Flickable {
        id: flicker

        anchors.fill: parent
        contentWidth: img.paintedWidth
        contentHeight: 854
        flickableDirection: Flickable.HorizontalFlick
        visible: !busyIndicator.visible
        Image {
            id: img
            fillMode: Image.PreserveAspectFit
            source: previewPage.url
            sourceSize.height: 854
            height: 854

            smooth: true
        }
    }

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: flicker
        visible: img.status === Image.Loading
        platformStyle: BusyIndicatorStyle { size: "large" }
        running: visible
    }
    ProgressBar {
        anchors.centerIn: flicker
        value: img.progress
        visible: img.status === Image.Loading
    }

    Rectangle {
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        color: '#80000000'

        height: previewColumn.height + 2*previewColumn.anchors.margins

        Column {
            id: previewColumn

            anchors {
                margins: 20
                top: parent.top
                left: parent.left
            }

            width: parent.width

            Label {
                text: previewPage.title
                font.bold: true
                font.pixelSize: 30
            }
            Label {
                text: qsTr('by %1').arg(previewPage.username)
                visible: previewPage.username !== ''
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: Qt.openUrlExternally(previewPage.website)
        }
    }

    Button {
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            margins: 20
        }

        text: qsTr('Use as wallpaper')
        visible: previewPage.favorite
        enabled: img.status == Image.Ready
        width: parent.width * .7
        onClicked: {
            QMLUtils.setWallpaper(img, flicker.contentX)
            showInfoBanner(qsTr("Wallpaper successfully set"))
        }
    }
}
