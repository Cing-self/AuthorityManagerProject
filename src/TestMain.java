import com.domain.PageInfo;
import com.domain.Role;
import com.domain.User;
import com.service.FnService;
import com.service.impl.FnServiceImpl;
import com.service.impl.RoleServiceImpl;
import com.service.impl.UserServiceImpl;
import pool.ConnectionPool;
import pool.MyConnection;
import pool.util.ConfigReader;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TestMain {

    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        FnService service = new FnServiceImpl();
        System.out.println(service.findAll());
    }
}
