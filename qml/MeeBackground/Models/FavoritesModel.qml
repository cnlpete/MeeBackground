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
    property bool running: false

    function getDB() {
        return openDatabaseSync("MeeBackground", "1.0", "FavoriteBackgrounds", 1000)
    }

    // At the start of the application, we can initialize the tables we need if they haven't been created yet
    function load() {
        var db = getDB()
        db.transaction(
                    function(tx) {
                        // Create the settings table if it doesn't already exist
                        // If the table exists, this is skipped
                        //                        tx.executeSql('DROP TABLE favorites')
                        tx.executeSql('CREATE TABLE IF NOT EXISTS favorites (id TEXT UNIQUE, title TEXT, username TEXT, path TEXT UNIQUE, source TEXT, addedat INT(11))')

                        // get all
                        var rs = tx.executeSql('SELECT * FROM favorites ORDER BY addedat DESC;')
                        for (var i = 0; i < rs.rows.length; i++) {
                            var obj = rs.rows.item(i)
                            if (QMLUtils.fileExists(obj.path)) {
                                var thumbpath = THUMBPATH + Qt.md5(obj.path) + ".jpg"
                                if (!QMLUtils.fileExists(thumbpath)) {
                                    console.log("thumb for " + obj.path + " does not exist, creating one at " + thumbpath)
                                    QMLUtils.makeThumbnail(obj.path, thumbpath, 480, 150) //TODO get these VALUES somewhere
                                }
                                root.append({
                                                id: obj.id,
                                                url: obj.path,
                                                thumb: thumbpath,
                                                title: obj.title,
                                                username: obj.username,
                                                source: obj.source,
                                                addedat: obj.addedat
                                            })
                            }
                            //else
                            //TODO
                            // remove from database?
                        }
                    })
    }

    function isFavorite(id, source) {
        for (var i = 0; i < root.count; i++) {
            var obj = root.get(i)
            if (obj.id == id && obj.source == source)
                return true
        }
        return false
    }

    function addFavorite(id, title, username, source, obj) {
        var dst = PATH + Qt.md5(source + id) + ".jpg"
        QMLUtils.saveImg(obj, dst)
        var thumbpath = THUMBPATH + Qt.md5(dst) + ".jpg"
        if (!QMLUtils.fileExists(thumbpath))
            QMLUtils.makeThumbnail(dst, thumbpath, 480, 150) //TODO get these VALUES somewhere

        var db = getDB()
        var res = false
        db.transaction(function(tx) {
                           var rs = tx.executeSql('INSERT OR REPLACE INTO favorites VALUES (?,?,?,?,?,?);', [id,title,username,dst,source,root.count])
                           //console.log(rs.rowsAffected)
                           res = rs.rowsAffected > 0
                       })
        if (res) {
            root.insert(0, {
                            id: id,
                            url: dst,
                            thumb: thumbpath,
                            title: title,
                            username: username,
                            source: source,
                            addedat: root.count
                        })
        }

        return res
    }

    function removeFavorite(id, source) {
        var db = getDB()
        var res = false
        db.transaction(function(tx) {
                           var rs = tx.executeSql('SELECT path FROM favorites WHERE id=? AND source=?;', [id, source])
                           //console.log(rs.rowsAffected)
                           if (rs.rows.length == 1) {
                               var obj = rs.rows.item(0)
                               QMLUtils.deleteFile(obj.path)
                               var thumbpath = THUMBPATH + Qt.md5(obj.path) + ".jpg"
                               if (QMLUtils.fileExists(thumbpath))
                                   QMLUtils.deleteFile(thumbpath)
                               // TODO check result
                               rs = tx.executeSql('DELETE FROM favorites WHERE id=? AND source=?;', [id, source])
                               //console.log(rs.rowsAffected)
                               res = rs.rowsAffected > 0
                           }
                       })
        if (res) {
            for (var i = root.count-1; i >= 0; i--) {
                var obj = root.get(i)
                if (obj.id === id && obj.source === source) {
                    root.remove(i)
                    // reset selected index
                    if (root.selectedIndex === i)
                        root.selectedIndex = -1
                    else if (root.selectedIndex > i)
                        root.selectedIndex--
                }
            }
            // reset selected index, if out of bounds
            if (root.selectedIndex >= root.count)
                root.selectedIndex = -1
        }

        return res
    }

    function getSelectedItem() {
        if (root.selectedIndex === -1)
            return null;

        return root.get(root.selectedIndex)
    }
}
