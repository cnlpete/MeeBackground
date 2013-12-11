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
import "../Models"

PageStackWindow {
    id: appWindow

    initialPage: mainPage

    FavoritesListView {
        orientationLock: PageOrientation.LockPortrait
        id: mainPage
    }

    DesktopprListView {
        id: onlineViews
    }

    PreviewPage {
        id: previewPage
    }

    Menu {
        id: myMenu
        visualParent: pageStack
        MenuLayout {
            MenuItem {
                text: qsTr('About MeeBackground')
                onClicked: pushAbout()
            }
        }
    }

    InfoBanner {
        id: myinfobanner
        text: ''
        timerShowTime: 15000
        timerEnabled: true
        anchors.top: parent.top
        anchors.topMargin: 60
        anchors.horizontalCenter: parent.horizontalCenter
    }

    function showInfoBanner(text) {
        myinfobanner.text = text
        myinfobanner.open()
    }

    FavoritesModel {
        id: favoritesModel
    }

    Component.onCompleted: {
        theme.inverted = true
        favoritesModel.load()
    }

    function pushAbout() {
        pageStack.push(Qt.createComponent(
                           Qt.resolvedUrl("AboutPage.qml")),
                       {
                           title : 'MeeBackground ' + APP_VERSION,
                           iconSource: Qt.resolvedUrl('/usr/share/icons/hicolor/80x80/apps/MeeBackground80.png'),
                           slogan : 'Because backgrounds are important !',
                           text :
                           'A nice looking wallpaper setting application.' +
                           '\nWeb Site : http://hauke-schade.de' +
                           '\n\nBy Hauke Schade' +
                           '\nLicenced under GPLv3' +
                           '\nWallpapers by desktoppr.co'+
                           '\n\nDerivated and Inspired by\nBenoît HERVIER (Khertan)\'s "Wleux" app' +
                           '\nhttp://khertan.net/Wleux' +
                           '\nwhich was inspired by Thomas Perl\'s "Mustr" app' +
                           '\nwhich was inspired by Lucas Rocha\'s "Pattrn" app' +
                           '\nMustr Tab support by Seppo Tomperi' +
                           '\n\nThanks to :' +
                           '\nBenoît HERVIER (Khertan)' +
                           '\nThomas Perl' +
                           '\nThe team running desktoppr.co' +
                           '\nFaenil on #harmattan'
                       }
                       );
    }
}
