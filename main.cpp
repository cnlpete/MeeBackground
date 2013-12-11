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

#include <QtGui/QApplication>
#include <QtDeclarative/QDeclarativeContext>
#include "qmlapplicationviewer.h"

#include "qmlutils.hh"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    app->setApplicationVersion(APP_VERSION);
    app->setApplicationName("MeeBackground");
    app->setOrganizationName("Hauke Schade");

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockPortrait);
    viewer.rootContext()->setContextProperty("QMLUtils", QMLUtils::instance());
    viewer.rootContext()->setContextProperty("APP_VERSION", APP_VERSION);

    viewer.rootContext()->setContextProperty("PATH", "/home/user/MyDocs/MeeBackground/");

    viewer.setMainQmlFile(QLatin1String("qml/Harmattan/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
