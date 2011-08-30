# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
CONFIG += qt-components #mobility
# MOBILITY +=

TARGET = SameGame
VERSION = 1.0.0

# Add more folders to ship with the application, here
qml_folder.source = qml/samegame
qml_folder.target = qml

DEPLOYMENTFOLDERS = qml_folder

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

symbian{

    TARGET.UID3 = 0xE1122D8B

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF
    DEPLOYMENT.installer_header = 0xA000D7CE


# Allow network access on Symbian
    TARGET.CAPABILITY += NetworkServices

}

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    README

RESOURCES += \
    resources.qrc
