#TODO stop thread when krita quits (callback)?
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
        self.server = osc_server.ThreadingOSCUDPServer(("127.0.0.1", 1239), self.dispatcher)
        print("Serving on {}".format(self.server.server_address))
        server_thread = threading.Thread(target=self.server.serve_forever)
        server_thread.start()
        print("----------------------------------------")
        
    def createActions(self, window):
        action = window.createAction(EXTENSION_ID, MENU_ENTRY, "tools/scripts")
        action.triggered.connect(self.action_triggered)
        #[print([a.objectName()]) for a in app.actions()]
        for a in app.actions():
            self.dispatcher.map("/"+str(a.objectName()), self.kritaActions)
        #print(app.filters())
        for b in app.filters():
            print("/"+str(b))
            self.dispatcher.map("/"+str(b), self.kritaFilters)

    def action_triggered(self):
        pass

    def kritaActions(self, unused_addr, args):
        #print("from OSC - kritaActions: "+str(unused_addr))
        app.action(unused_addr[1:]).trigger()

    def kritaFilters(self, unused_addr, args):
        #print("from OSC - kritaFilters: "+str(unused_addr))
        app.filter(unused_addr[1:])
        

# And add the extension to Krita's list of extensions:
app=Krita.instance()
extension=Thereminacrayon(parent=app) #instantiate your class
app.addExtension(extension)


