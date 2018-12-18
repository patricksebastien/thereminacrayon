import sys
from krita import *

class MyExtension(Extension):

    def __init__(self, parent):
        #This is initialising the parent, always  important when subclassing.
        super().__init__(parent)
        Krita.instance().action('show_color_selector').trigger()

    def setup(self):
        pass

    def createActions(self, window):
        action = window.createAction("myAction", "My Script", "tools/scripts")

# And add the extension to Krita's list of extensions:
Krita.instance().addExtension(MyExtension(Krita.instance()))