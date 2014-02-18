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

ListModel {
    id: root

    property int selectedIndex: -1
    property int page: 1
    property bool running: false

    function load() {
        var http = new XMLHttpRequest()
        http.open("GET", "https://api.desktoppr.co/1/wallpapers?page=" + page, true)

        http.setRequestHeader('Content-type','application/json; charset=utf-8')
        http.onreadystatechange = function() {
            if (http.readyState === XMLHttpRequest.DONE && http.status === 200)
                insertdata(http)
        }
        if (!root.running) {
            root.running = true
            http.send()
        }
    }

    function insertdata(httpreq) {
        var responseObject = JSON.parse(httpreq.responseText)
        for(var i = 0; i < responseObject.response.length; i++) {
            var obj = responseObject.response[i]
            root.append({
                            id:         obj.id,
                            thumb:      obj.image.thumb.url,
                            url:        obj.image.url,
                            source:     "DesktopPr",
                            title:      obj.image.url.replace(/\\/g, '/').replace(/.*\//, ''),
                            username:   obj.uploader
                        });
        }
        root.page = root.page + 1
        root.running = false
    }

    function getSelectedItem() {
        if (root.selectedIndex === -1)
            return null;

        return root.get(root.selectedIndex)
    }
}
