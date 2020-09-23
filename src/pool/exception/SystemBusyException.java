package pool.exception;

public class SystemBusyException extends RuntimeException {

    public SystemBusyException(){}

    public SystemBusyException(String msg){
        super(msg);
    }
}
