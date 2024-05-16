# Sensores ambientales

## Requerimientos BIPM




## Hardware provisto por Diego
En un porta video cassette
- cable usb A standard a mini-B
- Arduino nano en una plaqueta
- En una segunda plaqueta dos módulos de sensores


## Esquemática de conexión
Se dibujó un esquema de conexiones con el software [KiCad EDA](https://www.kicad.org) 


### AOSONG AM2302 | DHT 22 | Humedad y temperatura
- SN170336328
- sensor de temperatura y humedad
- [datasheet](https://www.makerguides.com/wp-content/uploads/2019/02/DHT22-AM2302-Datasheet.pdf)
- Entre el pin VCC y el canal de serie SDA debe haber un resistor de pull-up (bus idle -> high). Según el datasheet debe ser de 5,1 kohm, pero el que está soldado es de 3,0 kohm (entiedo que eso es un naranja decolorado) para que corresponda a la banda admisible de 1 a 10 kohm que se menciona en [DHT Temperature+Humidity Sensor](https://esphome.io/components/sensor/dht.html)


### GY-BM E/P 280 | BMP280 | Presión y temperatura
- Tiene marcado la P -> Es un BMP280, sensor de presión (
- Los pines se describen en [Components 101 | GY-BMP280 Module](https://components101.com/sensors/gy-bmp280-module)
- Página del del sensor [Bosch | Pressure sensor BMP280](https://www.bosch-sensortec.com/products/environmental-sensors/pressure-sensors/bmp280/)


### Shopping list
- DTH22
2024-03-04 9.108,00 ARS 
[TodoMicro | Sensor De Humedad Y Temperatura DHT22 Arduino](https://www.todomicro.com.ar/arduino/225-sensor-de-humedad-y-temperatura-dht22-arduino.html)

2024-03-04 $ 10.455,00 IVA Inc.
[it&t | Sensor Temperatura Y Humedad Dht22 Am2302 Rojo + Cable Itytarg](https://tienda.ityt.com.ar/sensor-temp-hum-interfaz/11423-sensor-temperatura-y-humedad-dht22-am2302-rojo-cable-itytarg.html)


2024-03-04 $11.200
[unibot | Módulo Sensor Termohigrómetro DHT22](https://www.unibot.com.ar/productos/modulo-termohigrometro-dht22/)



## Software
Recurro a la referencia del [Curso Arduino del LACIE de la UNLaM](http://www.lacie-unlam.org/dokuwiki/doku.php?id=lacie:ciclo_de_cursos_lacie_2020)
 
Instalo
- [Arduino IDE](https://www.arduino.cc/en/software) -> `/home/vbettachini/bin/arduino-ide_2.3.0_Linux_64bit` 
- [SimulIDE](https://simulide.com/p/) -> `/home/vbettachini/bin/SimulIDE_1.0.0-SR2_Lin64`


## Ensayo Nano
Un mensaje de error indicó que no tenía permiso de escritura en `/dev/ttyUSB0`. 
Este puerto pertenece a root y a él tiene acceso el grupo `dialout`.
Esto es común y se menciona en el [foro de Arduino](https://forum.arduino.cc/t/avrdude-ser_open-cant-open-device-dev-ttyusb0-permission-denied/603397/2).
Agrego mi usuario al grupo `sudo usermod -a -G dialout vbettachini`.
Tras agregarme al grupo debe realizar un logout y volvér a ingresar para que surta efecto el cambio.


Tras error `avrdude: stk500_getsync() attempt 1 of 10: not in sync: resp=0x00` encuentro solucíon en [Arduino Stack Exchange | How do I resolve "avrdude: stk500_recv(): programmer is not responding"?](https://arduino.stackexchange.com/questions/17827/how-do-i-resolve-avrdude-stk500-recv-programmer-is-not-responding).
se debe seleccionar el procesador adecuado en el menú `Tools -> Processors -> ATmega 328P Old Bootloader`

Comprobé la compilación y subida del binario a la placa del [código de ejemplo que hace parpadear a un led en la plaqueta](https://docs.arduino.cc/built-in-examples/basics/Blink/). 


### Lectura de presión desde el Nano
Según [](https://startingelectronics.org/tutorials/arduino/modules/pressure-sensor/) hay que cargar una biblioteca para leer los datos del sensor BMP280.
Para esto seleccionar el menu `Sketch → Include Library → Manage Libraries...` y buscar el driver para la BMP280 de Adafruit.
Entre las opciones está Adafruit BMP280 Library v. 2.6.8.
Me indica que requiere algunas dependencias, que instalo: 
```
Downloading Adafruit BMP280 Library@2.6.8
Adafruit BMP280 Library@2.6.8
Installing Adafruit BMP280 Library@2.6.8
Installed Adafruit BMP280 Library@2.6.8
Downloading Adafruit BusIO@1.15.0
Adafruit BusIO@1.15.0
Installing Adafruit BusIO@1.15.0
Installed Adafruit BusIO@1.15.0
Downloading Adafruit Unified Sensor@1.1.14
Adafruit Unified Sensor@1.1.14
Installing Adafruit Unified Sensor@1.1.14
Installed Adafruit Unified Sensor@1.1.14
```

Asimismo instalé, según indicación en la misma página la biblioteca I2c-Sensor-Lib iLib v. 0.8.2
```
Downloading I2C-Sensor-Lib iLib@0.8.2
I2C-Sensor-Lib iLib@0.8.2
Installing I2C-Sensor-Lib iLib@0.8.2
Installed I2C-Sensor-Lib iLib@0.8.2
```

Intenté probar el módulo con el código de ensayo al que se accede desde el menú `File → Examples → Adafruit BMP280 Library → bmp280test`.
Tras compilar la salida debe verse en el monitor del puerto serie al que se accede desde el menú `Tools -> Serial Monitor`.
But the device couldn't be found at the address 0x77


Instructions to [change I2C address](https://forum.arduino.cc/t/change-i2c-address/646612) led to make this changes at ``~/Arduino/libraries/Adafruit_BMP280_Library/Adafruit_BMP280.h`
```
#define BMP280_ADDRESS (0x76) /**< The default I2C address for the sensor. */
//#define BMP280_ADDRESS (0x77) /**< The default I2C address for the sensor. */
//#define BMP280_ADDRESS_ALT                                                     \
//  (0x76)                     /**< Alternative I2C address for the sensor. */
```
