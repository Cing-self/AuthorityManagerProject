package com.controller;

import com.domain.PageInfo;
import com.domain.User;
import com.service.UserService;
import com.util.ExcelUtil;
import com.util.MySpring;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.ss.usermodel.*;
import springmvc.ModelAndView;
import springmvc.annotation.RequestMapping;
import springmvc.annotation.RequestParam;
import springmvc.annotation.ResponseBody;
import springmvc.annotation.SessionAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@SessionAttributes("loginUser")
public class UserController {

    private UserService service = MySpring.getBean("com.service.impl.UserServiceImpl");

    @RequestMapping("login.do")
    public ModelAndView login(@RequestParam("uname") String uname, @RequestParam("upass") String upass){
        User user = service.checkLogin(uname, upass);
        if (user == null){
            //登录失败
            ModelAndView modelAndView = new ModelAndView();
            modelAndView.setViewName("redirect:index.jsp?flag=9");
            return modelAndView;
        }else {
            //登录成功
            String responeContext = "redirect:main.jsp";
            ModelAndView modelAndView = new ModelAndView();
            modelAndView.setViewName(responeContext);
            modelAndView.addAttribute("loginUser", user);
            return modelAndView;
        }
    }

    //该方法是为了实现分页查询
    @RequestMapping("getUserList.do")
    public ModelAndView getUserList(@RequestParam("uno") Integer uno, @RequestParam("uname")String uname,
                            @RequestParam("sex") String sex, @RequestParam("page") Integer page,
                            @RequestParam("row") Integer row){
        if (page == null && row == null){
            //没有传递page，应该是菜单访问，默认访问第一页
            page = 1;
            row = 5;
        }
        Map<String, Object> paramBox = new HashMap<>();
        paramBox.put("uno", uno);
        paramBox.put("uname", uname);
        paramBox.put("sex", sex);
        paramBox.put("page", page);
        paramBox.put("row", row);

        PageInfo info = service.findUserByPageAndFilter(paramBox);

        ModelAndView mv = new ModelAndView();
        mv.setViewName("userList.jsp");
        mv.addAttribute("pageInfo", info);
        mv.addAttribute("uno", uno);
        mv.addAttribute("uname", uname);
        mv.addAttribute("sex", sex);
        mv.addAttribute("page", page);
        mv.addAttribute("row", row);

        return mv;
    }

    @RequestMapping("addUser.do")
    public String addUser(User user){
        service.saveUser(user);
        return "redirect:getUserList.do";
    }

    @RequestMapping("userDelete.do")
    public String userDelete(@RequestParam("uno") Integer uno){
        service.deleteUser(uno);
        return "redirect:getUserList.do";
    }

    @RequestMapping("editUser.do")
    public ModelAndView editUser(@RequestParam("uno") Integer uno){
        User user = service.findUserById(uno);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("userEdit.jsp");
        mv.addAttribute("user", user);
        return mv;
    }

    @RequestMapping("userUpdate.do")
    public String userUpdate(User user){
        service.updateUser(user);
        return "redirect:getUserList.do";
    }

    @RequestMapping("userDeletes.do")
    public String userDeletes(@RequestParam("unoStr") String unoStr){
        service.deleteUserList(unoStr);
        return "redirect:getUserList.do";
    }

    @RequestMapping("importUser.do")
    public String importUser(HttpServletRequest request){
        DiskFileItemFactory fileItemFactory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(fileItemFactory);
        try {
            List<FileItem> fis = upload.parseRequest(request);
            FileItem fi = fis.get(0);
            InputStream is = fi.getInputStream();
            //读取文件内容
            List<User> userList = new ArrayList<>();
            System.out.println(userList);
            //把文件存入jvm里
            Workbook workbook = WorkbookFactory.create(is);
            //获取excel表格第一个sheet表
            Sheet sheet = workbook.getSheetAt(0);
            //表里sheet的表的每一行
            for (int i = 1; i <= sheet.getLastRowNum(); i ++){
                Row row = sheet.getRow(i);
                //获取每一列
                Cell c1 = row.getCell(0);
                Cell c2 = row.getCell(1);
                Cell c3 = row.getCell(2);
                Cell c4 = row.getCell(3);
                Cell c5 = row.getCell(4);

                String uname = c1.getStringCellValue();
                String upass = (int)c2.getNumericCellValue()+"";
                String realname = c3.getStringCellValue();
                int age = (int) c4.getNumericCellValue();
                String sex = c5.getStringCellValue();

                //包装成对象
                User user = new User(null, uname, upass, realname, sex, age, null, null);
                userList.add(user);
            }

            service.importUserList(userList);
        } catch (FileUploadException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "redirect:getUserList.do";
    }

    //用户文件模板下载
    @RequestMapping("UserTemplateDownload.do")
    public void userTemplateDownload(HttpServletResponse response){
        //获取模板文件输入流
        System.out.println(response);
        InputStream is = Thread.currentThread().getContextClassLoader().getResourceAsStream("files/users.xlsx");
        //获取响应输出流
        try {
            OutputStream os = response.getOutputStream();
            response.setHeader("content-disposition", "attachment;filename=users.xlsx");
            //讲文件写入输出流
            byte[] bytes = new byte[1024];
            int count;
            while ((count = is.read(bytes)) != -1){
                os.write(bytes, 0 , count);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            try {
                is.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @RequestMapping("exportUser.do")
    public void exportUser(HttpServletResponse response){
        List<User> userList = service.exportUserList();
        String[] headerName = {"用户编号","用户名称","真实姓名","用户性别","用户年龄"};
        try {
            //生成excel文件对象
            Workbook workbook = new ExcelUtil().createExcel(headerName, userList);
            //准备将jvm中的excel文件对象写到指定位置
            String path = Thread.currentThread().getContextClassLoader().getResource("").getPath();
            File file = new File(path, "users.xlsx");
            OutputStream osToLocal = new FileOutputStream(file);
            workbook.write(osToLocal);

            //将excel文件对象写回给浏览器
            InputStream is = new FileInputStream(file);
            //获取响应输出流
            OutputStream osToexploer = response.getOutputStream();
            response.setHeader("content-disposition", "attachment;filename=users.xlsx");
            //讲文件写入输出流
            byte[] bytes = new byte[1024];
            int count;
            while ((count = is.read(bytes)) != -1) {
                osToexploer.write(bytes, 0, count);
            }

            osToexploer.close();
            is.close();
            osToexploer.close();

        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("exitUser.do")
    public String exit(HttpServletRequest request){
        request.getSession().invalidate();
        return "redirect:index.jsp";
    }

    @RequestMapping("modifyPwd.do")
    @ResponseBody
    public String modifyPwd(@RequestParam("oldpass")String oldpass, @RequestParam("newpass")String newpass,HttpServletRequest request){
        User user = (User) request.getSession().getAttribute("loginUser");
        if (!user.getUpass().equals(oldpass)){
            return "原密码不正确";
        }
        user.setUpass(newpass);
        service.modifyPwd(user.getUno(), user.getUpass());

        return "密码修改成功";
    }
}
