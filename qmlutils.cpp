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

#include "qmlutils.hh"

#include <QDebug>
#include <QGraphicsObject>
#include <QPainter>
#include <QStyleOptionGraphicsItem>
#include <QFile>

#ifdef Q_OS_HARMATTAN
    #include <MDataUri>
    #include <QFileInfo>
    #include <maemo-meegotouch-interfaces/shareuiinterface.h>
    #include <gq/GConfItem>
#endif

QScopedPointer<QMLUtils> QMLUtils::m_instance(0);

QMLUtils::QMLUtils(QObject *parent) : QObject(parent) {
}

QMLUtils *QMLUtils::instance() {
    if (m_instance.isNull())
        m_instance.reset(new QMLUtils);

    return m_instance.data();
}

void QMLUtils::shareImg(const QString &filename) {
#ifdef Q_OS_HARMATTAN
    QString targetName;
    if (filename.at(0) == QChar('f')) {
        targetName = filename;
        targetName.replace(0,7,"");
    }
    else
        targetName = filename;

    QFileInfo shareFileInfo(targetName);
    QString shareFileURL = shareFileInfo.canonicalFilePath();

    if (shareFileURL.isEmpty())
        qDebug() << "Empty sharing file URL...";

    QStringList items;
    items << shareFileURL;

    ShareUiInterface shareIf("com.nokia.ShareUi");

    if (shareIf.isValid())
        shareIf.share(items);
    else
        qDebug() << "Invalid ShareUi";
#else
    qWarning("QMLUtils::shareImg(): This function only available on Harmattan");
    Q_UNUSED(filename)
#endif
}

void QMLUtils::shareUrl(const QString &link, const QString &title) {
#ifdef Q_OS_HARMATTAN
    MDataUri uri;
    uri.setMimeType("text/x-url");

    uri.setTextData(link);

    if (!title.isEmpty())
        uri.setAttribute("title", title);

    if (!uri.isValid()) {
        qCritical("QMLUtils::shareUrl(): Invalid URI");
        return;
    }

    ShareUiInterface shareIf("com.nokia.ShareUi");

    if (!shareIf.isValid()) {
        qCritical("QMLUtils::shareUrl(): Invalid Share UI interface");
        return;
    }

    shareIf.share(QStringList() << uri.toString());
#else
    qWarning("QMLUtils::shareUrl(): This function only available on Harmattan");
    Q_UNUSED(title)
    Q_UNUSED(link)
#endif
}

void QMLUtils::saveImg(QObject *imageObj, const QString &path) {
    QGraphicsObject *item = qobject_cast<QGraphicsObject*>(imageObj);

    if (!item) {
        qCritical("Item is NULL");
        return;
    }

    QImage img(item->boundingRect().size().toSize(), QImage::Format_RGB32);
    img.fill(QColor(255, 255, 255).rgb());
    QPainter painter(&img);
    QStyleOptionGraphicsItem styleOption;
    item->paint(&painter, &styleOption);
    img.save(path);
}

void QMLUtils::makeThumbnail(const QString &imgpath, const QString &thumbpath, int minwidth, int minheight) {
    QImage img(imgpath);

    int w = img.width();
    int h = img.height();

    float wscale = (float)w/(float)minwidth;
    float hscale = (float)h/(float)minheight;

    qDebug() << "size is " << w << "x" << h << ", resulting in scales " << wscale << " and " << hscale;

    if (wscale > hscale) {
        w /= hscale;
        h /= hscale;
    }
    else {
        w /= wscale;
        h /= wscale;
    }
    qDebug() << "New width and size are " << w << "x" << h;

    img = img.scaled(w, h);
    img.save(thumbpath);
}

bool QMLUtils::deleteFile(const QString &path) {
    if (QFile(path).exists())
        return QFile(path).remove();
    return false;
}

bool QMLUtils::fileExists(const QString &path) {
    return QFile(path).exists();
}

void QMLUtils::setWallpaper(QObject *imageObj, const int offset) {
#ifdef Q_OS_HARMATTAN
    QGraphicsObject *item = qobject_cast<QGraphicsObject*>(imageObj);

    if (!item) {
        qCritical("Item is NULL");
        return;
    }

    QImage img(item->boundingRect().size().toSize(), QImage::Format_RGB32);
    img.fill(QColor(255, 255, 255).rgb());
    QPainter painter(&img);
    QStyleOptionGraphicsItem styleOption;
    item->paint(&painter, &styleOption);
    img = img.scaledToHeight(854, Qt::SmoothTransformation);
    img = img.copy(offset, 0, 480, 854);
    img.save(WALLPATH);

    GConfItem *gc = new GConfItem(GCONFKEY);
    gc->set("");
    gc->set(WALLPATH);

    //TODO add offset to some table storing fav offsets

#else
    qWarning("QMLUtils::setWallpaper(): This function only available on Harmattan");
    Q_UNUSED(imageObj)
#endif
}
