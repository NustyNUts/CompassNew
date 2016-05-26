#include "gpiopi.h"


GpioPi::GpioPi(QObject *parent) :
    QObject(parent),pinLed(21),pinAcc(20)
{
    wiringPiSetupGpio();
    pinMode(pinLed,OUTPUT);
    digitalWrite(pinLed,LOW);
    timer = new QTimer();
    timerACC = new QTimer();
    connect(timer,SIGNAL(timeout()),this,SLOT(ledOff()));
    connect(timerACC,SIGNAL(timeout()),this,SLOT(checkACC()));
    accState = 2;
    emit updateAccState(accState);
    timerACC->start(1000);
}

void GpioPi::ledOn(){

    digitalWrite(pinLed,HIGH);
    timer->start(200);
}

void GpioPi::ledOff(){
    digitalWrite(pinLed,LOW);
    timer->stop();
}

void GpioPi::checkACC(){
    if(accState!=digitalRead(pinAcc)){
        accState = digitalRead(pinAcc);
        emit updateAccState(accState);
    }
}
