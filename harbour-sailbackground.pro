# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed

VERSION = 0.0.3
DEFINES += APP_VERSION=\\\"$$VERSION\\\"
DEFINES += WALLPATH=\\\"/home/user/.config/meebackground_wallpaper.png\\\"
DEFINES += GCONFKEY=\\\"/desktop/meego/background/portrait/picture_filename\\\"

DEFINES += Q_OS_SAILFISH

TARGET = harbour-sailbackground

##CONFIG += sailfishapp

QT += quick qml widgets

target.path = /usr/bin
INSTALLS += target

CONFIG += link_pkgconfig
PKGCONFIG += sailfishapp
INCLUDEPATH += /usr/include/sailfishapp

qml_1.files = qml/MeeBackground/Sailfish
qml_1.path = $$INSTALL_ROOT/usr/share/$$TARGET/qml
qml_2.files = qml/MeeBackground/Models
qml_2.path = $$INSTALL_ROOT/usr/share/$$TARGET/qml
INSTALLS += qml_1 qml_2

icon.files = images/$${TARGET}.png
icon.path = /usr/share/icons/hicolor/86x86/apps
INSTALLS += icon

desktop.files = harbour-sailbackground.desktop
desktop.path = /usr/share/applications
INSTALLS += desktop

HEADERS += qmlutils.hh

SOURCES += main.cpp \
    qmlutils.cpp

OTHER_FILES += rpm/harbour-sailbackground.spec \
    rpm/harbour-sailbackground.yaml \
    $$files(rpm/*)

