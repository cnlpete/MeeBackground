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
                            root.append({
                                            id: obj.id,
                                            url: obj.path,
                                            thumb: obj.path,
                                            title: obj.title,
                                            username: obj.username,
                                            source: obj.source,
                                            addedat: obj.addedat
                                        })
                        }
                    })

        ;; //TODO
    }

    function isFavorite(id, source) {
        var db = getDB()
        var res = false
        //console.log("checking for '" + id + "' from '" + source + "'")
        db.transaction(function(tx) {
                           var rs = tx.executeSql('SELECT id FROM favorites WHERE id=? AND source=?;', [id, source])
                           res = rs.rows.length > 0
                       })

        // The function returns false if no entry is found
        return res
    }

    function addFavorite(id, title, username, source, obj) {
        var dst = PATH + Qt.md5(source + id) + ".jpg"
        QMLUtils.saveImg(obj, dst)

        var db = getDB()
        //TODO
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
                            thumb: dst,
                            title: title,
                            username: username,
                            source: source,
                            addedat: root.count
                        })
        }

        return res
    }

    function getSelectedItem() {
        if (root.selectedIndex === -1)
            return null;

        return root.get(root.selectedIndex)
    }
}
