import os
import pytz
import inspect
from pathlib import Path
from datetime import datetime

class ExceptionHandler:
    # ExceptionHandler is a class where all try/exceåt blocks in the codebase use the .handle() method on any catched Exception.
    # This is to reuse and standardise how errors are handled across the codebase.
    
    def __init__(self):
        self.debug = False if int(os.environ.get("BOX_DEBUG", default="1")) == 0 else True
        self.log_location = os.path.join(Path(__file__).parent, "exception_log.txt")
        with open(self.log_location, "a") as f:
            f.write("ExceptionHandler initialized at: " + datetime.now(pytz.timezone('Europe/Copenhagen')).strftime("%Y/%m/%d, %H:%M:%S") + "\n")
    
    def reset_log(self, forced=False):
        """Resetting the log should only be possible in debug mode or if one is very sure in production"""
        if self.debug or forced:
            with open(self.log_location, "w") as f:
                f.write("ExceptionHandler reset log file at: " + datetime.now(pytz.timezone('Europe/Copenhagen')).strftime("%Y/%m/%d, %H:%M:%S") + "\n")
        else:
            with open(self.log_location, "a") as f:
                f.write("Failed to reset the log. Can only be reset in debug mode or if using the forced parameter. reset_log was called by this function: " + str(inspect.stack()[1][3]) + "\n")
    
    def handle(self, exception, log=False,show=False,crash=False):
        if not log and not show and not crash:
            raise Exception("ExceptionHandler not configured properly.\n" +
                        "ExceptionHandler has to have set at least one parameter of (log, show or crash) to True\n" +
                        "Error occured with the following exception:\n" +
                        str(exception))
            
        if log:
            with open(self.log_location, "a") as f:
                f.write(str(exception))
        if show:
            print(str(exception))
        if crash:
            raise Exception(exception)