#BBD's Krita Script Starter Feb 2018
import sys
import threading
from pythonosc import dispatcher
from pythonosc import osc_server
from krita import Extension

EXTENSION_ID = 'pykrita_thereminacrayon'
MENU_ENTRY = 'thereminacrayon'

class Thereminacrayon(Extension):

    def __init__(self, parent):
        #Always initialise the superclass, This is necessary to create the underlying C++ object 
        super().__init__(parent)
        

    def setup(self):
        print("---------------PYTHON VERSION-----------------")
        print(sys.version)
        print("---------------THEREMINACRAYON-----------------")
        self.dispatcher = dispatcher.Dispatcher()
        self.dispatcher.map("/filter", print)
        #notworking /volume...
        self.dispatcher.map("/volume", self.print_compute_handler, "Volume", 2)
        self.server = osc_server.ThreadingOSCUDPServer(("127.0.0.1", 1239), self.dispatcher)
        print("Serving on {}".format(self.server.server_address))
        server_thread = threading.Thread(target=self.server.serve_forever)
        server_thread.start()
        print("----------------------------------------")
        
    def createActions(self, window):
        action = window.createAction(EXTENSION_ID, MENU_ENTRY, "tools/scripts")
        # parameter 1 =  the name that Krita uses to identify the action
        # parameter 2 = the text to be added to the menu entry for this script
        # parameter 3 = location of menu entry
        action.triggered.connect(self.action_triggered)        
        
    def action_triggered(self):
        pass # your active code goes here. 

    def print_volume_handler(unused_addr, args, volume):
        print("[{0}] ~ {1}".format(args[0], volume))

    def print_compute_handler(unused_addr, args, volume):
        try:
            print("[{0}] ~ {1}".format(args[0], args[1](volume)))
        except ValueError: pass


# And add the extension to Krita's list of extensions:
app=Krita.instance()
extension=Thereminacrayon(parent=app) #instantiate your class
app.addExtension(extension)


