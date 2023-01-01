/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.utils;

import com.mycompany.spring_mvc_project_final.entities.BookingDetailEntity;
import com.mycompany.spring_mvc_project_final.entities.BookingEntity;
import com.mycompany.spring_mvc_project_final.entities.ServiceBookingEntity;
import javax.servlet.http.HttpSession;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

/**
 *
 * @author Administrator
 */
public class HomeUtils {

    public static boolean checkTwoPassword(String pass1, String pass2) {
        if (pass1.equals(pass2)) {
            return true;
        }
        return false;
    }

    public static String encodePassword(String password) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        return encoder.encode(password);
    }

    public static double getTotal(BookingEntity booking) {
        int day = (int) ((booking.getCheckout().getTime() - booking.getCheckin().getTime()) / 86400000);
        double total = 0;
        for (BookingDetailEntity bookingDetail : booking.getBookingDetails()) {
            total += bookingDetail.getPrice() * day;
            for (ServiceBookingEntity serviceBooking : bookingDetail.getServiceBookings()) {
                total += serviceBooking.getPrice() * serviceBooking.getQuantity();
            }
        }

        return total;
    }
    
    public static double getTotalService(BookingDetailEntity bookingDetail) {
         double totalService = 0;
        for (ServiceBookingEntity serviceBooking : bookingDetail.getServiceBookings()) {
            totalService += serviceBooking.getPrice() * serviceBooking.getQuantity();
        }
        return totalService;
    }
}
