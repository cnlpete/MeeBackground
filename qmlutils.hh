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

#ifndef QMLUTILS_HH
#define QMLUTILS_HH

#include <QtCore/QObject>
#include <QtCore/QVariant>
#include <QtCore/QScopedPointer>

class QMLUtils : public QObject
{
    Q_OBJECT
public:
    static QMLUtils *instance();

    // Share a link using Harmattan Share UI
    Q_INVOKABLE void shareUrl(const QString &link, const QString &title = QString());
    Q_INVOKABLE void shareImg(const QString &filename);
    Q_INVOKABLE void saveImg(QObject *imageObj, const QString &path);
    Q_INVOKABLE void makeThumbnail(const QString &imgpath, const QString &thumbpath, int minwidth, int minheight);
    Q_INVOKABLE bool deleteFile(const QString &path);
    Q_INVOKABLE bool fileExists(const QString &path);
    Q_INVOKABLE void setWallpaper(QObject *imageObj, const int offset);

private:
    static QScopedPointer<QMLUtils> m_instance;

    explicit QMLUtils(QObject *parent = 0);
    Q_DISABLE_COPY(QMLUtils)
};

#endif // QMLUTILS_HH
