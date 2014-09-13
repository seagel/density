#include <QtGui/QGuiApplication>
#include <QQmlComponent>
#include <QQuickItem>
#include "qtquick2applicationviewer.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/Example1/main.qml"));
    viewer.setMaximumSize(QSize(500,500));
    viewer.setPosition(QPoint(500,100));
    viewer.showExpanded();




//    QQuickItem *object = viewer.rootObject();
//    QObject *childObject = object->findChild<QObject*>("maincanvas");

      //QQmlEngine engine = viewer.engine();
    //QQmlEngine *engine = new QQmlEngine;

//    QQmlComponent component(viewer.engine(), QUrl::fromLocalFile("qml/Example1/apple_object.qml"));
//    QObject *apple_object = component.create();
//    QQuickItem *apple_q_object = qobject_cast<QQuickItem*>(apple_object);
//    apple_q_object -> setParent(childObject);
    //viewer.engine() -> context() -> setContextProperty("_apple", apple_object);
//    object->children() << apple_object;




    return app.exec();
}

void new_method (int a) {
    printf("Hello");
}
