VERSION = 0.0.2
DEFINES += APP_VERSION=\\\"$$VERSION\\\"
DEFINES += WALLPATH=\\\"/home/user/.config/meebackground_wallpaper.png\\\"
DEFINES += GCONFKEY=\\\"/desktop/meego/background/portrait/picture_filename\\\"

# Add more folders to ship with the application, here
folder_01.source = qml/MeeBackground/Harmattan
folder_01.target = qml
folder_02.source = qml/MeeBackground/Models
folder_02.target = qml
DEPLOYMENTFOLDERS = folder_01 folder_02

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

symbian:TARGET.UID3 = 0xE6FDE20C

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

# Allow network access on Symbian
symbian:TARGET.CAPABILITY += NetworkServices

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
CONFIG += qdeclarative-boostable
contains(MEEGO_EDITION,harmattan) {
    # disable to make builds for use with meecolay
    CONFIG += shareuiinterface-maemo-meegotouch share-ui-plugin share-ui-common
    DEFINES += Q_OS_HARMATTAN
    PKGCONFIG += gq-gconf
}

# Add dependency to Symbian components
# CONFIG += qt-components

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp\
    qmlutils.cpp

HEADERS += \
    qmlutils.hh

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/manifest.aegis \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog \
    images/MeeBackground.svg \
    images/MeeBackground64.png \
    images/MeeBackground80.png

contains(MEEGO_EDITION,harmattan) {
    icon.files = images/MeeBackground80.png
    icon.path = /usr/share/icons/hicolor/80x80/apps
    INSTALLS += icon

    splash.files = images/MeeBackground-splash-portrait.jpg images/MeeBackground-splash-landscape.jpg
    splash.path = /opt/$${TARGET}/splash
    INSTALLS += splash
}
