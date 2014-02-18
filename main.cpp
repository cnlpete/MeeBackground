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

#if defined(Q_OS_SAILFISH)
    #include <QGuiApplication>
    #include <sailfishapp.h>
    #ifdef QT_QML_DEBUG
        #include <QtQuick>
    #endif
#else
    #include <QtGui/QApplication>
    #include <QDeclarativeContext>
    #include "qmlapplicationviewer.h"
#endif

#include <QDir>

#include "qmlutils.hh"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
#if defined(Q_OS_SAILFISH)
    QGuiApplication *app = SailfishApp::application(argc, argv);
#else
    QScopedPointer<QApplication> app(createApplication(argc, argv));
#endif

    app->setApplicationVersion(APP_VERSION);
    app->setApplicationName("MeeBackground");
    app->setOrganizationName("Hauke Schade");

#if defined(Q_OS_SAILFISH)
    QQuickView* viewer = SailfishApp::createView();
#else
    QmlApplicationViewer *viewer = new QmlApplicationViewer();
    viewer->setOrientation(QmlApplicationViewer::ScreenOrientationLockPortrait);
    viewer->rootContext()->setContextProperty("QMLUtils", QMLUtils::instance());
#endif

    viewer->rootContext()->setContextProperty("APP_VERSION", APP_VERSION);

    if (!QDir("/home/user/MyDocs/MeeBackground/").exists())
        QDir().mkdir("/home/user/MyDocs/MeeBackground/");
    if (!QDir("/home/user/MyDocs/MeeBackground/.thumbnails/").exists())
        QDir().mkdir("/home/user/MyDocs/MeeBackground/.thumbnails/");
    viewer->rootContext()->setContextProperty("PATH", "/home/user/MyDocs/MeeBackground/");
    viewer->rootContext()->setContextProperty("THUMBPATH", "/home/user/MyDocs/MeeBackground/.thumbnails/");

#ifdef Q_OS_HARMATTAN
    viewer->setMainQmlFile(QLatin1String("qml/Harmattan/main.qml"));
#elif defined(Q_OS_SAILFISH)
    viewer->setSource(SailfishApp::pathTo("qml/Sailfish/harbour-sailbackground.qml"));
#endif

#ifdef Q_OS_HARMATTAN
    viewer->showExpanded();
#elif defined(Q_OS_SAILFISH)
    viewer->show();
#else
    viewer->showExpanded();
#endif

    return app->exec();
}
