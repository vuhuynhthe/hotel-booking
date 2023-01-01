/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.utils;

import com.mycompany.spring_mvc_project_final.entities.ImageEntity;
import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import com.mycompany.spring_mvc_project_final.entities.RoomCategoryEntity;
import com.mycompany.spring_mvc_project_final.entities.ServiceEntity;
import java.io.File;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author Administrator
 */
public class ManagerUtils {

    public static int getPages(int x, int y) {
        int pages = x / y;
        if (pages >= 2 && x % y == 0) {
            pages--;
        }
        return pages;
    }

    public static void saveImageService(HttpServletRequest servletRequest, ServiceEntity service, MultipartFile[] files) {
        Set<ImageEntity> images = new HashSet<>();
        String path = servletRequest.getServletContext().getRealPath("/");
        String pathSave = path.substring(0, path.indexOf("target")) + "src\\main\\webapp\\resources\\img\\service";
        for (MultipartFile mf : files) {
            String fileName = mf.getOriginalFilename();
            if (!fileName.isEmpty()) {
                ImageEntity image = new ImageEntity();
                image.setName(fileName);
                image.setService(service);
                images.add(image);

                File imageFile = new File(pathSave, fileName);
                try {
                    mf.transferTo(imageFile);
                } catch (Exception e) {
                }
            }
            service.setImages(images);
        }
    }

    public static void saveImageRoomCategory(HttpServletRequest servletRequest, RoomCategoryEntity roomCategory, MultipartFile[] files) {
        Set<ImageEntity> images = new HashSet<>();
        String path = servletRequest.getServletContext().getRealPath("/");
        String pathSave = path.substring(0, path.indexOf("target")) + "src\\main\\webapp\\resources\\img\\category";
        for (MultipartFile mf : files) {
            String fileName = mf.getOriginalFilename();
            if (!fileName.isEmpty()) {
                ImageEntity image = new ImageEntity();
                image.setName(fileName);
                image.setRoomCategory(roomCategory);
                images.add(image);

                File imageFile = new File(pathSave, fileName);
                try {
                    mf.transferTo(imageFile);
                } catch (Exception e) {
                }
            }
            roomCategory.setImages(images);
        }
    }

    public static void saveImagePromotion(HttpServletRequest servletRequest, PromotionEntity promotion, MultipartFile file) {
        String path = servletRequest.getServletContext().getRealPath("/");
        String pathSave = path.substring(0, path.indexOf("target")) + "src\\main\\webapp\\resources-management\\img\\promotion";
        String fileName = file.getOriginalFilename();
        if (!fileName.isEmpty()) {
            promotion.setImage(fileName);

            File imageFile = new File(pathSave, fileName);
            try {
                file.transferTo(imageFile);
            } catch (Exception e) {
            }
        }
    }

    public static Date formatDate(String date) throws ParseException {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Date day = df.parse(date);

        return day;
    }

    public static String formatDate(Date date) throws ParseException {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String day = df.format(date);

        return day;
    }

    public static String loadDate(Date date) throws ParseException {
        DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
        String day = df.format(date);

        return day;
    }

    public static String loadDateTime(Date date) throws ParseException {
        DateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        String day = df.format(date);

        return day;
    }

    public static String formatDateTime(Date date) throws ParseException {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String day = df.format(date);

        return day;
    }

    public static String formatPrice(double price) {
        DecimalFormat df = new DecimalFormat("###,###,###");

        return df.format(price);
    }

    public static int getMonth() {
        Date date = new Date();
        LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        int month = localDate.getMonthValue();

        return month;
    }

    public static int getDay() {
        Date date = new Date();
        LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        int day = localDate.getDayOfMonth();

        return day;
    }

    public static double convertStringToNumber(String number) throws ParseException {
        NumberFormat format = NumberFormat.getInstance();
        double value = format.parse(number).doubleValue();

        return value;
    }
}
