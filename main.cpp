#include <QtGui/QGuiApplication>
#include <QQmlComponent>
#include <QQuickItem>
#include "qtquick2applicationviewer.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/Example1/main.qml"));
    viewer.setPosition(QPoint(500,100));
    viewer.setMaximumSize(QSize(540,740));
    viewer.showExpanded();

    return app.exec();
}
