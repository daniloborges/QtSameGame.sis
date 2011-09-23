#include <QtGui/QApplication>
#include <QTranslator>
#include <QLocale>
#include <QLibraryInfo>
#include <QDebug>
#include "qmlapplicationviewer.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    app.setApplicationVersion(APP_VERSION);

    const char *translate_files[] =  {
        "GamePage",
        "WonDialog",
        "engine"
    };

    QTranslator tbase;
    for (int i = 0; i < 3; ++i) {
        QTranslator* translator = new QTranslator();
        translator->load(translate_files[i]+QLatin1String("_")+QLocale::system().name(), QLatin1String(":/i18n"));
        QApplication::installTranslator(translator);
    }

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
