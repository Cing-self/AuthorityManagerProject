package springmvc;

public class MethodNoParamException extends RuntimeException {

    public MethodNoParamException(){}
    public MethodNoParamException(String mess){
        super(mess);
    }
}
