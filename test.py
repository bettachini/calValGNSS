import pyvisa
rm = pyvisa.ResourceManager()
print(rm.list_resources())
pyvisa.ResourceManager('@py')