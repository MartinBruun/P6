
class ExceptionHandler{
  // ExceptionHandler is a class where all try/catch blocks in the codebase use the .handle() method on any catched Exception.
  // This is to reuse and standardise how errors are handled across the codebase.

  // Flutter will highly likely have its own way of handling exceptions.
  // It would be nice though, if these ways of handling exceptions are "wrapped" in a custom class
  // So everyone knows where to look for, and improve, security "stuff", rather than it being spread out

  bool handle(exception, {log=false, show=false, crash=false}){
    if (log==false && show==false && crash==false){
      throw new Exception("ExceptionHandler not configured properly.\n" +
                        "ExceptionHandler has to have set at least one parameter of (log, show or crash) to True\n" +
                        "Error occured with the following exception:\n" +
                        exception.toString());
    }

    return true;
  }
}