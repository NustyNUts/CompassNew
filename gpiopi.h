#ifndef GPIOPI_H
#define GPIOPI_H

#include <QObject>
#include <QTimer>
#include <QDebug>
#include "wiringPi.h"



class GpioPi : public QObject
{
    Q_OBJECT
    int pinLed;
    int pinAcc;
    QTimer *timer;
    QTimer *timerACC;
    int accState;
public:
    explicit GpioPi(QObject *parent = 0);


signals:
    void updateAccState(bool);

public slots:
    void ledOff();
    void ledOn();
    void checkACC();
};

#endif // GPIOPI_H
