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
    #include <QDebug>
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


#if defined(Q_OS_SAILFISH)
    if (!QDir(QDir::homePath() + "/MeeBackground/").exists())
        QDir().mkdir(QDir::homePath() + "/MeeBackground/");
    if (!QDir(QDir::homePath() + "/MeeBackground/.thumbnails/").exists())
        QDir().mkdir(QDir::homePath() + "/MeeBackground/.thumbnails/");

    viewer->rootContext()->setContextProperty("PATH", QDir::homePath() + "/MeeBackground/");
    viewer->rootContext()->setContextProperty("THUMBPATH", QDir::homePath() + "/MeeBackground/.thumbnails/");
#else
    if (!QDir(QDir::homePath() + "/MyDocs/MeeBackground/").exists())
        QDir().mkdir(QDir::homePath() + "/MyDocs/MeeBackground/");
    if (!QDir(QDir::homePath() + "/MyDocs/MeeBackground/.thumbnails/").exists())
        QDir().mkdir(QDir::homePath() + "/MyDocs/MeeBackground/.thumbnails/");

    viewer->rootContext()->setContextProperty("PATH", QDir::homePath() + "/MyDocs/MeeBackground/");
    viewer->rootContext()->setContextProperty("THUMBPATH", QDir::homePath() + "/MyDocs/MeeBackground/.thumbnails/");
#endif

#if defined(Q_OS_SAILFISH)
    viewer->setSource(SailfishApp::pathTo("qml/Sailfish/harbour-sailbackground.qml"));
#else
    viewer->setMainQmlFile(QLatin1String("qml/Harmattan/main.qml"));
#endif

#if defined(Q_OS_SAILFISH)
    viewer->show();
#else
    viewer->showExpanded();
#endif

    return app->exec();
}
