#BBD's Krita Script Starter Feb 2018
import sys
import liblo
from krita import Extension

EXTENSION_ID = 'pykrita_thereminacrayon'
MENU_ENTRY = 'thereminacrayon'

global server

class Thereminacrayon(Extension):

    def __init__(self, parent):
        #Always initialise the superclass, This is necessary to create the underlying C++ object 
        super().__init__(parent)
        print("----------------------------------------")
        print("----------------------------------------")
        print(sys.version)
        print("---------------INIT OSC-----------------")
        try:
            server = liblo.Server(1239)
        except liblo.ServerError as err:
            print(err)
            sys.exit()
        print("----------------------------------------")
        print("----------------------------------------")
        print("----------------------------------------")
        print("----------------------------------------")


        # OF COURSE PUTTING THIS HERE DOESNT WORK...
        while True:
            server.recv(100)


    def setup(self):
        pass
        
    def createActions(self, window):
        action = window.createAction(EXTENSION_ID, MENU_ENTRY, "tools/scripts")
        # parameter 1 =  the name that Krita uses to identify the action
        # parameter 2 = the text to be added to the menu entry for this script
        # parameter 3 = location of menu entry
        action.triggered.connect(self.action_triggered)        
        
    def action_triggered(self):
        pass # your active code goes here. 


# And add the extension to Krita's list of extensions:
app=Krita.instance()
extension=Thereminacrayon(parent=app) #instantiate your class
app.addExtension(extension)


