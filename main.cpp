#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);


    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
#ifdef QT_COMPONENTS
    viewer.setMainQmlFile(QLatin1String("qml/components/main.qml"));
#else
    viewer.setMainQmlFile(QLatin1String("qml/samegame/main.qml"));
#endif
    viewer.showExpanded();

    return app.exec();
}
