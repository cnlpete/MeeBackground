/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "../Models"

ApplicationWindow {
    id: root
    initialPage: Component { FavoritesListView { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")

    FavoritesModel {
        id: favoritesModel

        thumbWidth: Screen.width
    }
//    PreviewPage {
//        id: previewPage
//    }

    Component.onCompleted: {
        favoritesModel.load()
    }

    function pushAbout() {
        var params = {
            title : 'SailBackground ' + APP_VERSION,
            iconSource: Qt.resolvedUrl('/usr/share/icons/hicolor/86x86/apps/harbour-sailbackground.png'),
            slogan : 'Because backgrounds are important !',
            donatebutton: qsTr("Buy me a beer"),
            donateurl: "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=WUWGSGAK8K7ZN",
            text: 'A nice looking wallpaper setting application.' +
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
                  '\nFaenil on #harmattan',
//            homepageurl: constant.sourceRepoSite,
            issuetrackertext: qsTr("If you encounter bugs or have feature requests, please visit the Issue Tracker"),
            issuetrackerurl: "https://github.com/cnlpete/meebackground/issues"
        }
        pageStack.push("pages/AboutPage.qml", params)
    }
}





