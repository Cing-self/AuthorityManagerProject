package com.util;

import com.domain.User;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

public class ExcelUtil {

    public <T> List<T> parseExcel(InputStream inputStream){
        List<T> list = new ArrayList<>();

        return list;
    }

    public Workbook createExcel(String[] header, List<User> objList) throws IllegalAccessException, InstantiationException {
        if (!(header !=null && objList != null && objList.size() > 0))
            return null;
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet();
        int rows = 0;
        int count = header.length;
        {
            if (count > 0){
                //创建第一行，把标题放进去
                Row headRow = sheet.createRow(rows++);
                Cell[] headCells = new Cell[count];
                for (int i = 0; i < count; i ++){
                    String headerName =  header[i];
                    headCells[i] = headRow.createCell(i);
                    headCells[i].setCellValue(headerName);
                }
            }
        }
        for (User user : objList){
            Row row = sheet.createRow(rows ++);
            Cell c1 = row.createCell(0);
            Cell c2 = row.createCell(1);
            Cell c3 = row.createCell(2);
            Cell c4 = row.createCell(3);
            Cell c5 = row.createCell(4);
            c1.setCellValue(user.getUno());
            c2.setCellValue(user.getUname());
            c3.setCellValue(user.getRealname());
            c4.setCellValue(user.getSex());
            c5.setCellValue(user.getAge());
        }

        return workbook;
    }
}
