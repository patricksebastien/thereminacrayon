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
        self.dispatcher.map("/zoom", self.zoom)
        self.dispatcher.map("/canvasonly", self.canvasonly)
        self.server = osc_server.ThreadingOSCUDPServer(("127.0.0.1", 1239), self.dispatcher)
        print("Serving on {}".format(self.server.server_address))
        server_thread = threading.Thread(target=self.server.serve_forever)
        server_thread.start()
        print("----------------------------------------")
        
    def createActions(self, window):
        action = window.createAction(EXTENSION_ID, MENU_ENTRY, "tools/scripts")
        action.triggered.connect(self.action_triggered)        
        
    def action_triggered(self):
        pass

    def zoom(self, unused_addr, args):
        if int(args) < 0:
            app.action('view_zoom_out').trigger()
        else:
            app.action('view_zoom_in').trigger()
    
    def canvasonly(self, unused_addr, args):
        app.action('view_show_canvas_only').trigger()


# And add the extension to Krita's list of extensions:
app=Krita.instance()
extension=Thereminacrayon(parent=app) #instantiate your class
app.addExtension(extension)


