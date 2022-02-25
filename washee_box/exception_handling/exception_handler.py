import os

class ExceptionHandler:
    
    def __init__(self):
        pass
    
    def reset_log(self, forced=False):
        # Resets the logfile if running in debug mode. Otherwise the forced option needs to be set
        pass
    
    def handle(self, exception, log=False,show=False,crash=False):
        if not log and not show and not crash:
            raise Exception("ExceptionHandler not configured properly.\n" +
                        "ExceptionHandler has to have set at least one parameter of (log, print or crash) to True\n" +
                        "Error occured with the following exception:\n" +
                        str(exception))
            
            
    def _log_exception(self, exception):
        pass
    
    def _show_exception(self, exception):
        pass
    
    def _crash_exception(self, exception):
        pass