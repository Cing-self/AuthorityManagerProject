package com.util;

import java.util.HashMap;
import java.util.Map;

public class MySpring {

    private static Map<String, Object> beanBox = new HashMap<>();

    public static <T>T getBean(String objName){
        T obj = (T) beanBox.get(objName);
        if (obj == null){
            try {
                obj = (T) Class.forName(objName).newInstance();
                beanBox.put(objName, obj);
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InstantiationException e) {
                e.printStackTrace();
            }
        }
        return obj;
    }
}
