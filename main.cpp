#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    app.setApplicationVersion(APP_VERSION);

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockPortrait);
#ifdef QT_COMPONENTS
    viewer.setMainQmlFile(QLatin1String("qml/components/main.qml"));
#else
    viewer.setMainQmlFile(QLatin1String("qml/samegame/main.qml"));
#endif
    viewer.showExpanded();

    return app.exec();
}
