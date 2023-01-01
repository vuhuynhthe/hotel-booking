/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.BookingDetailEntity;
import com.mycompany.spring_mvc_project_final.entities.BookingEntity;
import com.mycompany.spring_mvc_project_final.entities.RoomEntity;
import com.mycompany.spring_mvc_project_final.entities.ServiceBookingEntity;
import com.mycompany.spring_mvc_project_final.service.BookingDetailServiceImpl;
import com.mycompany.spring_mvc_project_final.service.CategoryRoomServiceImpl;
import com.mycompany.spring_mvc_project_final.service.FeedBackServiceImpl;
import com.mycompany.spring_mvc_project_final.service.RoomServiceImpl;
import com.mycompany.spring_mvc_project_final.service.ServiceBookingServiceImpl;
import com.mycompany.spring_mvc_project_final.service.ServiceServiceImpl;
import com.mycompany.spring_mvc_project_final.utils.HomeUtils;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author win
 */
@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private BookingDetailServiceImpl bookingDetailServiceImpl;

    @Autowired
    private RoomServiceImpl roomServiceImpl;

    @Autowired
    private CategoryRoomServiceImpl categoryRoomServiceImpl;

    @Autowired
    private FeedBackServiceImpl feedBackServiceImpl;

    @Autowired
    private ServiceServiceImpl serviceServiceImpl;
    @Autowired
    private ServiceBookingServiceImpl serviceBookingServiceImpl;

    @RequestMapping(value = "/view", method = RequestMethod.GET)
    public String viewCart(Model model, HttpSession session) {
        BookingEntity booking = (BookingEntity) session.getAttribute("bookingSession");
        model.addAttribute("total", HomeUtils.getTotal(booking));
        return "cart";
    }

    @RequestMapping(value = "/buy/{id}", method = RequestMethod.GET)
    public String buy(Model model, HttpSession session, @PathVariable long id) {
        BookingEntity booking = (BookingEntity) session.getAttribute("bookingSession");
        List<BookingDetailEntity> bookingDetails = booking.getBookingDetails();

        RoomEntity room = roomServiceImpl.getRoom(id);
        boolean contain = false;
        if (room != null) {
            if (bookingDetails != null && bookingDetails.size() > 0) {
                for (BookingDetailEntity b : bookingDetails) {
                    if (b.getRoom().getId() == id) {
                        contain = true;
                    }
                }
                if (contain) {
                    model.addAttribute("mess", "Quý khách đã chọn phòng này ! Xin cảm ơn !");
                    return "cart";
                } else {
                    BookingDetailEntity bookingDetail = new BookingDetailEntity();
                    bookingDetail.setBooking(booking);
                    bookingDetail.setRoom(room);
                    bookingDetail.setPrice(room.getRoomCategory().getPrice());
                    bookingDetails.add(bookingDetail);
                }
            } else {
                BookingDetailEntity bookingDetail = new BookingDetailEntity();
                bookingDetail.setBooking(booking);
                bookingDetail.setRoom(room);
                bookingDetail.setPrice(room.getRoomCategory().getPrice());
                bookingDetails.add(bookingDetail);
            }

        }
        booking.setBookingDetails(bookingDetails);
        session.setAttribute("roomcategoryId", room.getRoomCategory().getId());
        session.setAttribute("bookingSession", booking);
        session.setAttribute("bookingDetails", bookingDetails);
        session.setAttribute("roomId", id);
        return "redirect:/cart/view";
    }

    @RequestMapping("/delete-room/{index}")
    public String deleteRoom(Model model, HttpSession session,
            @PathVariable("index") int index) {
        List<BookingDetailEntity> bookingDetails = (List<BookingDetailEntity>) session.getAttribute("bookingDetails");
        bookingDetails.remove(index);
        if (bookingDetails.size() == 0) {
            session.removeAttribute("roomId");
            session.removeAttribute("bookingSession");
            return "redirect:/home";
        }
        session.setAttribute("bookingDetails", bookingDetails);
        return "redirect:/cart/view";
    }

    @RequestMapping(value = "/service/{index}", method = RequestMethod.GET)
    public String viewService(Model model, HttpSession session,
            @PathVariable(value = "index") int index) {
        model.addAttribute("services", serviceServiceImpl.getServices());
        BookingEntity bookingsession = (BookingEntity) session.getAttribute("bookingSession");
        BookingDetailEntity bookingDetail = (BookingDetailEntity) bookingsession.getBookingDetails().get(index);
        session.setAttribute("bookingDetail", bookingDetail);
        session.setAttribute("index", index);
        model.addAttribute("totalService", HomeUtils.getTotalService(bookingDetail));
        return "service";
    }

    @RequestMapping(value = "/add-service", method = RequestMethod.POST)
    public String addService(Model model, HttpSession session,
            @RequestParam(value = "serviceId") long id,
            @RequestParam(value = "usedate") Date date,
            @RequestParam(value = "quantity") int quantity) {
        model.addAttribute("services", serviceBookingServiceImpl.getServices());
        BookingEntity bookingsession = (BookingEntity) session.getAttribute("bookingSession");
        BookingDetailEntity bookingDetail = (BookingDetailEntity) session.getAttribute("bookingDetail");

        Date checkin = bookingDetail.getBooking().getCheckin();
        Date checkout = bookingDetail.getBooking().getCheckout();
        if (checkout.getTime() <= date.getTime() || date.getTime() < checkin.getTime()) {
            model.addAttribute("services", serviceServiceImpl.getServices());
            model.addAttribute("mess", "Dịch vụ chỉ được sử dụng trong thời gian thuê phòng !!! Xin Cảm ơn !");
            return "service";
        }
        int index = -1;
        for (int i = 0; i < bookingDetail.getServiceBookings().size(); i++) {
            long diff = date.getTime() - bookingDetail.getServiceBookings().get(i).getUseDate().getTime();
            if (bookingDetail.getServiceBookings().get(i).getService().getId() == id && diff == 0) {
                index = i;
            }
        }

        if (index == -1) {
            ServiceBookingEntity serviceBooking = new ServiceBookingEntity();
            serviceBooking.setService(serviceServiceImpl.getService(id));
            serviceBooking.setUseDate(date);
            serviceBooking.setPrice(serviceServiceImpl.getService(id).getPrice());
            serviceBooking.setQuantity(quantity);
            serviceBooking.setBookingDate(new Date());
            bookingDetail.getServiceBookings().add(serviceBooking);
        } else {
            bookingDetail.getServiceBookings().get(index).setQuantity(bookingDetail.getServiceBookings().get(index).getQuantity() + quantity);
        }

        int index2 = (int) session.getAttribute("index");

        session.setAttribute("bookingDetail", bookingDetail);
        return "redirect:/cart/service/" + index2;
    }

    @RequestMapping("/delete-service/{index}")
    public String deleteService(Model model, HttpSession session,
            @PathVariable("index") int index) {
        model.addAttribute("services", serviceBookingServiceImpl.getServices());
        BookingDetailEntity bookingDetail = (BookingDetailEntity) session.getAttribute("bookingDetail");

        bookingDetail.getServiceBookings().remove(index);
        int index2 = (int) session.getAttribute("index");
        session.setAttribute("bookingDetail", bookingDetail);
        return "redirect:/cart/service/" + index2;
    }

    @RequestMapping("/saveAll")
    public String saveAll(Model model, HttpSession session) {
        BookingDetailEntity bookingDetail = (BookingDetailEntity) session.getAttribute("bookingDetail");
        session.setAttribute("bookingSession", bookingDetail.getBooking());
        session.setAttribute("bookingDetail", bookingDetail);
        return "redirect:/cart/view";
    }
}
