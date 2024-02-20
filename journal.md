# Journal

## 2024-02-19
Tras conectar con cable USB al TIC BNC el código
```
inst = rm.open_resource('USB0::0x164E::0x0FA4::TW00048101::INSTR')
print(inst.query("*IDN?"))
```
indicó que requería la biblioteca `pyusb`. Tras instalarla con `pip install pyusb`.
Con eso bastó para lograr comunicarse.

Ahora le pide automáticamente la descripción de la dirección USB.

Alimenté con dos señales cuadradas de 1.2 kHz a través de dos cables de distinta longitud.

Levanta el código `intento.ipynb`, cada minuto, frecuencia en un canal y diferencia de fase entre ambas.



## 2024-02-08

### Py-visa
Following [](https://pyvisa.readthedocs.io/en/latest/introduction/getting.html) I installed both the frontend
as well as the backend (avoiding propietary ones from National Instruments or Keysight). 
```
source ~/bin/jupyter/bin/activate
pip install -U pyvisa
pip install -U pyvisa-py
```
Further details on this backend figures at [](https://pyvisa.readthedocs.io/projects/pyvisa-py/en/latest/)

#### Test
Copied the test code to `test.py`
```
import pyvisa
rm = pyvisa.ResourceManager()
print(rm.list_resources())
```
After a warning on IP connections a further install with `pip install zeroconf` was made to support IP based connections.

Execution by `python3 test.py` shown no errors or warnings.


### TIC measurement
Using BNC 1105

ch 2- ch 1
Source: PPS from distribuitor
BNC-T at ch1 entry 
After T a cable connected to ch 2 reported (1V threshold) 52 ns
Antenna cable with TNC male terminals

Interspacing the antenna cable: two BNC female barrels and two tnc female - bnc male adapters 
-> 380.9 ns (1 V threshold), 383.1 ns (2 V threshold), none (3 V), 395.1 ns (2.5 V), 380.6 ns (0.5 V, the recommended level in Rovera et al 2015)

Al measurements data at [Cuaderno receptor viajero](https://www.overleaf.com/project/65c50c5770ce777dd70478c1)
