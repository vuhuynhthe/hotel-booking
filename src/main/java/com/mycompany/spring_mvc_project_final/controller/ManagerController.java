/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.AccountBankingEntity;
import com.mycompany.spring_mvc_project_final.entities.BookingDetailEntity;
import com.mycompany.spring_mvc_project_final.entities.BookingEntity;
import com.mycompany.spring_mvc_project_final.entities.ConvenientEntity;
import com.mycompany.spring_mvc_project_final.entities.ImageEntity;
import com.mycompany.spring_mvc_project_final.entities.PaymentEntity;
import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import com.mycompany.spring_mvc_project_final.entities.RoomCategoryEntity;
import com.mycompany.spring_mvc_project_final.entities.RoomEntity;
import com.mycompany.spring_mvc_project_final.entities.ServiceBookingEntity;
import com.mycompany.spring_mvc_project_final.entities.ServiceEntity;
import com.mycompany.spring_mvc_project_final.entities.VisitorEntity;
import com.mycompany.spring_mvc_project_final.enums.BookingStatus;
import com.mycompany.spring_mvc_project_final.enums.Position;
import com.mycompany.spring_mvc_project_final.enums.RoomStatus;
import com.mycompany.spring_mvc_project_final.enums.ServiceStatus;
import com.mycompany.spring_mvc_project_final.service.AccountBankingServiceImpl;
import com.mycompany.spring_mvc_project_final.service.BookingDetailServiceImpl;
import com.mycompany.spring_mvc_project_final.service.BookingServiceImpl;
import com.mycompany.spring_mvc_project_final.service.CategoryRoomServiceImpl;
import com.mycompany.spring_mvc_project_final.service.ConvenientServiceImpl;
import com.mycompany.spring_mvc_project_final.service.FeedBackServiceImpl;
import com.mycompany.spring_mvc_project_final.service.PaymentServiceImpl;
import com.mycompany.spring_mvc_project_final.service.PromotionServiceImpl;
import com.mycompany.spring_mvc_project_final.service.RoomServiceImpl;
import com.mycompany.spring_mvc_project_final.service.ServiceServiceImpl;
import com.mycompany.spring_mvc_project_final.service.VisitorServiceImpl;
import com.mycompany.spring_mvc_project_final.utils.HomeUtils;
import com.mycompany.spring_mvc_project_final.utils.InvoicePDFExporter;
import com.mycompany.spring_mvc_project_final.utils.ManagerUtils;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author Administrator
 */
@Controller
@RequestMapping("/manager")
public class ManagerController {

    @Autowired
    private CategoryRoomServiceImpl categoryRoomServiceImpl;

    @Autowired
    private RoomServiceImpl roomServiceImpl;

    @Autowired
    private ServiceServiceImpl serviceServiceImpl;

    @Autowired
    private ConvenientServiceImpl convenientServiceImpl;

    @Autowired
    private PromotionServiceImpl promotionServiceImpl;

    @Autowired
    private BookingServiceImpl bookingServiceImpl;

    @Autowired
    private BookingDetailServiceImpl bookingDetailServiceImpl;

    @Autowired
    private VisitorServiceImpl visitorServiceImpl;

    @Autowired
    private AccountBankingServiceImpl accountBankingServiceImpl;

    @Autowired
    private PaymentServiceImpl paymentServiceImpl;

    @Autowired
    private FeedBackServiceImpl feedBackServiceImpl;

    // 1.Home manager
    @RequestMapping("/home")
    public String homePage(Model model) {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        List<BookingEntity> monthBookings = bookingServiceImpl.getBookingByMonth(ManagerUtils.getMonth());
        double monthTotal = 0;
        for (BookingEntity booking : monthBookings) {
            monthTotal += HomeUtils.getTotal(booking);
        }
        model.addAttribute("monthTotal", ManagerUtils.formatPrice(monthTotal));

        List<BookingEntity> dayBookings = bookingServiceImpl.getBookingByDay(ManagerUtils.getDay());
        double dayTotal = 0;
        for (BookingEntity booking : dayBookings) {
            dayTotal += HomeUtils.getTotal(booking);
        }
        model.addAttribute("dayTotal", ManagerUtils.formatPrice(dayTotal));

        model.addAttribute("username", username);
        model.addAttribute("numbersOfBooking", bookingServiceImpl.getBookings().size());
        model.addAttribute("roomAvaiable", roomServiceImpl.getRoomByStatus(RoomStatus.AVAILABLE).size());
        model.addAttribute("visitors", visitorServiceImpl.getVisitors().size());
        model.addAttribute("roomUnAvaiable", roomServiceImpl.getRoomByStatus(RoomStatus.UNAVAILABLE).size());
        model.addAttribute("payments", paymentServiceImpl.getPayments().size());
        model.addAttribute("feedbacks", feedBackServiceImpl.getFeedBack());

        return "management/home";
    }

    // 2.Room category
    @GetMapping("/view-room-category")
    public String categoryPage(Model model,
            @RequestParam(name = "page", required = false, defaultValue = "0") int page,
            @RequestParam(name = "size", required = false, defaultValue = "10") int size) {
        List<RoomCategoryEntity> categories = categoryRoomServiceImpl.getCategories(page, size);
        model.addAttribute("categories", categories);
        int pages = 0;
        if (categoryRoomServiceImpl.getCategories().size() > size) {
            pages = ManagerUtils.getPages(categoryRoomServiceImpl.getCategories().size(), size);
        }
        model.addAttribute("pages", pages);
        model.addAttribute("page", page);
        model.addAttribute("size", size);
        model.addAttribute("statuses", RoomStatus.values());
        model.addAttribute("convenients", convenientServiceImpl.getConvenients());

        return "management/categories";
    }

    @PostMapping("/add-rcategory")
    public String addRoomCategory(@ModelAttribute("category") RoomCategoryEntity category,
            @RequestParam MultipartFile[] files,
            HttpServletRequest request) {
        ManagerUtils.saveImageRoomCategory(request, category, files);
        categoryRoomServiceImpl.addRoomCategory(category);

        return "redirect:/manager/view-room-category";
    }

    @PostMapping("/update-rcategory")
    public String updateRoomCategory(@ModelAttribute("category") RoomCategoryEntity category,
            @RequestParam MultipartFile[] files,
            HttpServletRequest request) {

        Set<ImageEntity> images = categoryRoomServiceImpl.getCategory(category.getId()).getImages();

        if (files[0].getSize() > 0) {
            ManagerUtils.saveImageRoomCategory(request, category, files);
        } else {
            category.setImages(images);
        }
        categoryRoomServiceImpl.updateRoomCategory(category);

        return "redirect:/manager/view-room-category";
    }

    @GetMapping("/delete-rcategory")
    public String deleteRoomCategory(@RequestParam long id) {
        categoryRoomServiceImpl.deleteRoomCategory(id);

        return "redirect:/manager/view-room-category";
    }

    @PostMapping("/put-convenient")
    public String putCovenient(@RequestParam long id,
            @RequestParam(required = false) long[] convenients) {
        RoomCategoryEntity roomCategoryEntity = categoryRoomServiceImpl.getCategory(id);
        Set<ConvenientEntity> convenientss = new HashSet<>();
        if (convenients != null && convenients.length > 0) {
            for (int i = 0; i < convenients.length; i++) {
                ConvenientEntity convenient = convenientServiceImpl.getConvenient(convenients[i]);
                convenientss.add(convenient);
            }
            roomCategoryEntity.setConvenients(convenientss);
            categoryRoomServiceImpl.saveRoomCategory(roomCategoryEntity);
        } else {
            roomCategoryEntity.setConvenients(convenientss);
            categoryRoomServiceImpl.saveRoomCategory(roomCategoryEntity);
        }

        return "redirect:/manager/view-room-category";
    }

    // 3.Room
    @GetMapping("/view-room")
    public String roomPage(Model model,
            @RequestParam(name = "page", required = false, defaultValue = "0") int page,
            @RequestParam(name = "size", required = false, defaultValue = "10") int size) {
        List<RoomEntity> rooms = roomServiceImpl.getRooms(page, size);
        model.addAttribute("rooms", rooms);

        int pages = 0;
        if (roomServiceImpl.getRooms().size() > size) {
            pages = ManagerUtils.getPages(roomServiceImpl.getRooms().size(), size);

        }
        model.addAttribute("pages", pages);

        model.addAttribute("page", page);
        model.addAttribute("size", size);
        model.addAttribute("rCategories", categoryRoomServiceImpl.getCategories());
        model.addAttribute("positions", Position.values());
        model.addAttribute("statuses", RoomStatus.values());

        return "management/rooms";
    }

    @PostMapping("/add-room")
    @ResponseBody
    public String addRoom(Model model,
            @ModelAttribute("room") RoomEntity room) {
        if (roomServiceImpl.getRoom(room.getRoomNumber()) == null) {
            roomServiceImpl.saveRoom(room);
            return "Added success";
        }

        return "fail";
    }

    @PostMapping("/save-room")
    public String saveRoom(Model model,
            @ModelAttribute("room") RoomEntity room) {
        if (roomServiceImpl.getRoom(room.getRoomNumber()) == null || roomServiceImpl.getRoom(room.getRoomNumber()).getRoomNumber().equals(room.getRoomNumber())) {

            roomServiceImpl.saveRoom(room);
            return "redirect:/manager/view-room";
        }

        model.addAttribute("message", "room number already exists");
        return "management/rooms";
    }

    @GetMapping("/delete-room")
    public String deleteRoom(@RequestParam long id) {
        roomServiceImpl.deleteRoom(id);

        return "redirect:/manager/view-room";
    }

    // 4.Service
    @GetMapping("/view-service")
    public String servicePage(Model model,
            @RequestParam(name = "page", required = false, defaultValue = "0") int page,
            @RequestParam(name = "size", required = false, defaultValue = "10") int size) {
        List<ServiceEntity> services = serviceServiceImpl.getServices(page, size);
        model.addAttribute("services", services);
        int pages = 0;
        if (serviceServiceImpl.getServices().size() > size) {
            pages = ManagerUtils.getPages(serviceServiceImpl.getServices().size(), size);
        }
        model.addAttribute("pages", pages);
        model.addAttribute("page", page);
        model.addAttribute("size", size);
        model.addAttribute("positions", Position.values());
        model.addAttribute("statuses", ServiceStatus.values());

        return "management/services";
    }

    @PostMapping("/add-service")
    public String addService(@ModelAttribute("service") ServiceEntity service,
            @RequestParam MultipartFile[] files,
            HttpServletRequest request) {

        ManagerUtils.saveImageService(request, service, files);
        serviceServiceImpl.addService(service);

        return "redirect:/manager/view-service";
    }

    @PostMapping("/save-service")
    public String saveService(@ModelAttribute("service") ServiceEntity service,
            @RequestParam MultipartFile[] files,
            HttpServletRequest request) {
        Set<ImageEntity> images = serviceServiceImpl.getService(service.getId()).getImages();

        if (files[0].getSize() > 0) {
            ManagerUtils.saveImageService(request, service, files);
        } else {
            service.setImages(images);
        }

        serviceServiceImpl.updateService(service);

        return "redirect:/manager/view-service";
    }

    @GetMapping("/delete-service")
    public String deleteService(@RequestParam long id) {
        serviceServiceImpl.deleteService(id);

        return "redirect:/manager/view-service";
    }

    // 5.Conveient
    @GetMapping("/view-convenient")
    public String convenientPage(Model model,
            @RequestParam(name = "page", required = false, defaultValue = "0") int page,
            @RequestParam(name = "size", required = false, defaultValue = "10") int size) {
        List<ConvenientEntity> convenients = convenientServiceImpl.getConvenients(page, size);
        model.addAttribute("convenients", convenients);
        int pages = 0;
        if (convenientServiceImpl.getConvenients().size() > size) {
            pages = ManagerUtils.getPages(convenientServiceImpl.getConvenients().size(), size);
        }
        model.addAttribute("pages", pages);
        model.addAttribute("page", page);
        model.addAttribute("size", size);

        return "management/convenients";
    }

    @PostMapping("/add-convenient")
    public String addConveient(@RequestParam String name) {
        ConvenientEntity convenient = new ConvenientEntity();
        convenient.setName(name);
        convenientServiceImpl.saveConvenient(convenient);

        return "redirect:/manager/view-convenient";
    }

    @PostMapping("/update-convenient")
    public String updateConveient(@RequestParam long id,
            @RequestParam String name) {
        ConvenientEntity convenient = convenientServiceImpl.getConvenient(id);
        convenient.setName(name);
        convenientServiceImpl.saveConvenient(convenient);

        return "redirect:/manager/view-convenient";
    }

    @GetMapping("/delete-convenient")
    public String deleteConvenient(@RequestParam long id) {
        convenientServiceImpl.deleteConvenient(id);

        return "redirect:/manager/view-convenient";
    }

    // 6.Promotion
    @GetMapping("/view-promotion")
    public String promotionPage(Model model,
            @RequestParam(name = "page", required = false, defaultValue = "0") int page,
            @RequestParam(name = "size", required = false, defaultValue = "10") int size) {
        List<PromotionEntity> promotions = promotionServiceImpl.getPromotions(page, size);
        model.addAttribute("promotions", promotions);
        int pages = 0;
        if (promotionServiceImpl.getPromotions().size() > size) {
            pages = ManagerUtils.getPages(promotionServiceImpl.getPromotions().size(), size);

        }
        model.addAttribute("pages", pages);
        model.addAttribute("page", page);
        model.addAttribute("size", size);

        return "management/promotions";
    }

    @PostMapping("/add-promotion")
    public String addPromotion(@ModelAttribute("promotion") PromotionEntity promotion,
            @RequestParam MultipartFile file,
            HttpServletRequest servletRequest) {

        ManagerUtils.saveImagePromotion(servletRequest, promotion, file);
        if (promotionServiceImpl.getCode(promotion.getCode()) == null) {
            promotionServiceImpl.savePromotion(promotion);
        }

        return "redirect:/manager/view-promotion";
    }

    @PostMapping("/update-promotion")
    public String updatePromotion(@ModelAttribute("promotion") PromotionEntity promotion,
            @RequestParam(required = false) MultipartFile file,
            HttpServletRequest servletRequest) {
        String image = promotionServiceImpl.getPromotion(promotion.getId()).getImage();

        if (file.getSize() > 0) {
            ManagerUtils.saveImagePromotion(servletRequest, promotion, file);
        } else {
            promotion.setImage(image);
        }

        if (promotionServiceImpl.getCode(promotion.getCode()) == null || promotionServiceImpl.getCode(promotion.getCode()).getCode().equals(promotion.getCode())) {
            promotionServiceImpl.savePromotion(promotion);
        }

        return "redirect:/manager/view-promotion";
    }

    @GetMapping("/delete-promotion")
    public String deletePromotion(@RequestParam long id) {
        promotionServiceImpl.deletePromotion(id);

        return "redirect:/manager/view-promotion";
    }

    // 7.Booking
    @GetMapping("/view-booking")
    public String bookingPage(Model model,
            @RequestParam(name = "page", required = false, defaultValue = "0") int page,
            @RequestParam(name = "size", required = false, defaultValue = "10") int size) {
        List<BookingEntity> bookings = bookingServiceImpl.getBookings(page, size);
        model.addAttribute("bookings", bookings);
        int pages = 0;
        if (bookingServiceImpl.getBookings().size() > size) {
            pages = ManagerUtils.getPages(bookingServiceImpl.getBookings().size(), size);
        }
        model.addAttribute("pages", pages);
        model.addAttribute("page", page);
        model.addAttribute("size", size);
        model.addAttribute("roomCategories", categoryRoomServiceImpl.getCategories());

        return "management/bookings";
    }

    @PostMapping("/add-booking")
    @ResponseBody
    public String addBooking(@RequestParam String name,
            @RequestParam String email,
            @RequestParam String phoneNumber,
            @RequestParam String birthDate,
            @RequestParam String checkin,
            @RequestParam String checkout,
            @RequestParam(required = false) String note,
            @RequestParam long categoryId,
            @RequestParam int quantity) throws ParseException {

        Set<RoomEntity> setRooms = roomServiceImpl.findRoomAvaiable(ManagerUtils.formatDate(checkin), ManagerUtils.formatDate(checkout), categoryId);
        if ((ManagerUtils.formatDate(checkout).getTime() - ManagerUtils.formatDate(checkin).getTime()) / 86400000 <= 0) {
            return "error1";
        }
        if (setRooms.size() < quantity) {
            return "error2";
        }
        BookingEntity booking = new BookingEntity();
        booking.setName(name);
        booking.setEmail(email);
        booking.setPhoneNumber(phoneNumber);
        booking.setBirthDate(ManagerUtils.formatDate(birthDate));
        booking.setCheckin(ManagerUtils.formatDate(checkin));
        booking.setCheckout(ManagerUtils.formatDate(checkout));
        if (note != null) {
            booking.setNote(note);
        }
        List<RoomEntity> rooms = new ArrayList<>(setRooms);
        for (int i = 0; i < quantity; i++) {
            BookingDetailEntity bookingDetail = new BookingDetailEntity();
            bookingDetail.setBooking(booking);
            bookingDetail.setRoom(rooms.get(i));
            bookingDetail.setPrice(rooms.get(i).getRoomCategory().getPrice());
            booking.getBookingDetails().add(bookingDetail);
        }
        bookingServiceImpl.addBooking(booking);

        return bookingServiceImpl.getNewBookingByEmail(email).getId() + "";

    }

    @PostMapping("/update-booking")
    public String updateBooking(@ModelAttribute("booking") BookingEntity booking) {
        booking.setBookingDetails(bookingServiceImpl.getBooking(booking.getId()).getBookingDetails());
        bookingServiceImpl.updateBooking(booking);

        return "redirect:/manager/booking/" + booking.getId();
    }

    @GetMapping("/delete-booking")
    public String deleteBooking(@RequestParam long id) {
        bookingServiceImpl.deleteBooking(id);

        return "redirect:/manager/view-booking";
    }

    @PostMapping("/search-booking")
    public String searchBooking(Model model,
            @RequestParam(required = false) String email,
            @RequestParam(required = false) String checkin,
            @RequestParam(required = false) String checkout) throws ParseException {
        List<BookingEntity> bookings = new ArrayList<>();
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        if (email != null) {
            bookings = bookingServiceImpl.findBookingByEmail(email);
        } else if (checkin != null) {
            bookings = bookingServiceImpl.findBookingByCheckin(df.parse(checkin));
        } else if (checkout != null) {
            bookings = bookingServiceImpl.findBookingByCheckout(df.parse(checkout));
        }
        if (bookings.isEmpty()) {
            model.addAttribute("errorSearch", "Not found");
            return "management/bookings";
        }
        model.addAttribute("roomCategories", categoryRoomServiceImpl.getCategories());
        model.addAttribute("bookings", bookings);
        return "management/bookings";
    }

    // 8.Booking detail
    @GetMapping("/booking/{id}")
    public String loadBookingDetail(Model model,
            @PathVariable(value = "id") long id) throws ParseException {
        BookingEntity booking = bookingServiceImpl.getBooking(id);
        model.addAttribute("booking", booking);
        model.addAttribute("statuses", BookingStatus.values());
        model.addAttribute("services", serviceServiceImpl.getServices());
        model.addAttribute("day", (int) ((booking.getCheckout().getTime() - booking.getCheckin().getTime()) / 86400000));
        model.addAttribute("total", ManagerUtils.formatPrice(booking.total()));

        return "management/booking-detail";
    }

    @GetMapping("/booking/create-session-bdetail")
    @ResponseBody
    public String createBookingDetailSession(@RequestParam long id, HttpSession session) {
        BookingDetailEntity bookingDetail = bookingDetailServiceImpl.getBookingDetail(id);
        session.setAttribute("bookingDetail", bookingDetail);

        return id + "";
    }

    @GetMapping("/booking/load-service-detail")
    @ResponseBody
    public String loadServiceDetail(HttpSession session) throws ParseException {
        String html = "";
        BookingDetailEntity bookingDetail = (BookingDetailEntity) session.getAttribute("bookingDetail");
        List<ServiceBookingEntity> serviceBookings = bookingDetail.getServiceBookings();
        Set<ServiceBookingEntity> set = new LinkedHashSet<>();
        set.addAll(serviceBookings);
        serviceBookings.clear();
        serviceBookings.addAll(set);
        for (int i = 0; i < serviceBookings.size(); i++) {
            html += "<div class=\"row col-sm-12\">\n"
                    + "<div class=\"col-sm-4 border\">" + serviceBookings.get(i).getService().getName() + "</div>\n"
                    + "<div class=\"col-sm-2 border\">" + ManagerUtils.formatPrice(serviceBookings.get(i).getPrice()) + "</div>\n"
                    + "<div class=\"col-sm-2 border\">" + ManagerUtils.loadDate(serviceBookings.get(i).getUseDate()) + "</div>\n"
                    + "<div class=\"col-sm-2 border\">" + serviceBookings.get(i).getQuantity() + "</div>\n"
                    + "<div class=\"col-sm-2 border\"><button class=\"border badge badge-danger\" onclick=\"deletService(" + i + "," + bookingDetail.getId() + ")\"><i class=\"fas fa-trash-alt m-r-5\"></i>Remove</button></div>\n"
                    + "</div>";
        }

        return html;
    }

    @PostMapping("/booking/add-service-detail")
    @ResponseBody
    public String addServiceDetail(@RequestParam long serviceId,
            @RequestParam String useDate,
            @RequestParam int quantity,
            HttpSession session) throws ParseException {
        Date useDay = ManagerUtils.formatDate(useDate);

        BookingDetailEntity bookingDetail = (BookingDetailEntity) session.getAttribute("bookingDetail");
        Date checkin = bookingDetail.getBooking().getCheckin();
        Date checkout = bookingDetail.getBooking().getCheckout();
        if (useDay.getTime() < checkin.getTime() || useDay.getTime() >= checkout.getTime()) {
            return "1";
        }

        int index = -1;
        for (int i = 0; i < bookingDetail.getServiceBookings().size(); i++) {
            long diff = useDay.getTime() - bookingDetail.getServiceBookings().get(i).getUseDate().getTime();
            if (bookingDetail.getServiceBookings().get(i).getService().getId() == serviceId && diff == 0) {
                index = i;
            }
        }

        if (index == -1) {
            ServiceBookingEntity serviceBooking = new ServiceBookingEntity();
            serviceBooking.setService(serviceServiceImpl.getService(serviceId));
            serviceBooking.setUseDate(useDay);
            serviceBooking.setPrice(serviceServiceImpl.getService(serviceId).getPrice());
            serviceBooking.setQuantity(quantity);
            serviceBooking.setBookingDate(new Date());
            serviceBooking.setBookingDetail(bookingDetail);
            bookingDetail.getServiceBookings().add(serviceBooking);
        } else {
            bookingDetail.getServiceBookings().get(index).setQuantity(bookingDetail.getServiceBookings().get(index).getQuantity() + quantity);
        }

        session.setAttribute("bookingDetail", bookingDetail);
        return "done";
    }

    @PostMapping("/booking/delete-service-detail")
    @ResponseBody
    public String deleteServiceDetail(HttpSession session,
            @RequestParam int index) {
        BookingDetailEntity bookingDetail = (BookingDetailEntity) session.getAttribute("bookingDetail");
        bookingDetail.getServiceBookings().remove(index);

        return "Remove service successful";
    }

    @PostMapping("/booking/booking-status")
    @ResponseBody
    public String changeStatus(@RequestParam long bookingId,
            @RequestParam String status) {
        BookingEntity booking = bookingServiceImpl.getBooking(bookingId);
        booking.setStatus(BookingStatus.valueOf(status));
        bookingServiceImpl.updateBooking(booking);

        return "OK";
    }

    @GetMapping("/booking/load-visitor")
    @ResponseBody
    public String loadVisitor(HttpSession session) throws ParseException {
        String html = "";
        BookingDetailEntity bookingDetail = (BookingDetailEntity) session.getAttribute("bookingDetail");
        List<VisitorEntity> visitors = new ArrayList<>(bookingDetail.getVisitors());
        for (int i = 0; i < visitors.size(); i++) {
            String gender = "";
            if (visitors.get(i).isGender()) {
                gender = "Female";
            } else {
                gender = "Male";
            }
            html += "<div class=\"row col-sm-12\">\n";
            if (bookingDetail.getBooking().getStatus() == BookingStatus.CHECK_OUT) {
                html += "<div class=\"col-sm-2 border\">" + (i + 1) + "</div>\n";
            }
            html += "<div class=\"col-sm-2 border\">" + visitors.get(i).getName() + "</div>\n"
                    + "<div class=\"col-sm-2 border\">" + visitors.get(i).getIdCard() + "</div>\n"
                    + "<div class=\"col-sm-2 border\">" + visitors.get(i).getPhoneNumber() + "</div>\n"
                    + "<div class=\"col-sm-2 border\">" + ManagerUtils.loadDate(visitors.get(i).getBirthDate()) + "</div>\n"
                    + "<div class=\"col-sm-2 border\">" + gender + "</div>\n";
            if (bookingDetail.getBooking().getStatus() != BookingStatus.CHECK_OUT) {
                html += "<div class=\"col-sm-2 border\"><button class=\"border badge badge-danger\" onclick=\"deletVisitor(" + i + "," + bookingDetail.getId() + ")\"><i class=\"fas fa-trash-alt m-r-5\"></i>Remove</button></div>\n";
            }
            html += "</div>";
        }

        return html;
    }

    @PostMapping("/booking/add-visitor")
    @ResponseBody
    public String addVisitor(@RequestParam String name,
            @RequestParam(required = false) String idCard,
            @RequestParam(required = false) String phoneNumber,
            @RequestParam String birthDate,
            @RequestParam boolean gender,
            HttpSession session) throws ParseException {
        BookingDetailEntity bookingDetail = (BookingDetailEntity) session.getAttribute("bookingDetail");

        if (bookingDetail.getVisitors().size() >= bookingDetail.getRoom().getRoomCategory().getCapacity()) {
            return "fail";
        }

        VisitorEntity visitor = new VisitorEntity();
        visitor.setName(name);
        visitor.setIdCard(idCard);
        visitor.setPhoneNumber(phoneNumber);
        visitor.setBirthDate(ManagerUtils.formatDate(birthDate));
        visitor.setGender(gender);
        visitor.setCreateDate(new Date());
        visitor.setBookingDetailEntity(bookingDetail);

        bookingDetail.getVisitors().add(visitor);
        session.setAttribute("bookingDetail", bookingDetail);

        return "done";
    }

    @PostMapping("/booking/delete-visitor")
    @ResponseBody
    public String deleteVisitor(HttpSession session,
            @RequestParam int index) {
        BookingDetailEntity bookingDetail = (BookingDetailEntity) session.getAttribute("bookingDetail");
        List<VisitorEntity> visitors = new ArrayList<>(bookingDetail.getVisitors());
        visitors.remove(index);
        Set<VisitorEntity> visitorss = new HashSet<>(visitors);
        bookingDetail.setVisitors(visitorss);

        return "Remove visitor successful";
    }

    @PostMapping("/booking/update-bdetail")
    @ResponseBody
    public String updateBookingDetail(HttpSession session) {
        BookingDetailEntity bookingDetail = (BookingDetailEntity) session.getAttribute("bookingDetail");
        bookingDetailServiceImpl.save(bookingDetail);

        return "OK";
    }

    @PostMapping("/booking/payment")
    @ResponseBody
    public String payment(@RequestParam long bookingId,
            @RequestParam(required = false) String note,
            @RequestParam String cardNumber,
            HttpSession session) throws ParseException {
        PaymentEntity payment = new PaymentEntity();
        BookingEntity booking = bookingServiceImpl.getBooking(bookingId);
        AccountBankingEntity accountBanking = accountBankingServiceImpl.getAccountBankingByCartNumber(cardNumber);

        if (accountBanking == null) {
            return "ERROR1";
        } else if (accountBanking.getBalance() < booking.total()) {
            return "ERROR2";
        }

        PromotionEntity promotion = (PromotionEntity) session.getAttribute("promotionCode");
        if (promotion != null) {
            List<BookingEntity> bookings = bookingServiceImpl.findBookingByEmail(booking.getEmail());
            boolean contain = false;
            if (!bookings.isEmpty()) {
                for (BookingEntity b : bookings) {
                    if (b.getCode() != null && b.getCode().equals(promotion.getCode())) {
                        contain = true;
                    }
                }
            }
            if (!contain) {
                promotion.setQuantity(promotion.getQuantity() - 1);
                booking.setPromotion(promotion);
                booking.setCode(promotion.getCode());
                booking.setDiscount(promotion.getDiscount());
                promotionServiceImpl.savePromotion(promotion);
            }
        }

        booking.setStatus(BookingStatus.COMPLETED);

        payment.setBooking(booking);
        payment.setAmount(booking.total());
        payment.setAccountBanking(accountBanking);
        if (!note.isEmpty()) {
            payment.setNote(note);
        }
        payment.setPaymentDate(new Date());
        booking.getPayments().add(payment);
        bookingServiceImpl.updateBooking(booking);

        accountBanking.setBalance(accountBanking.getBalance() - payment.getAmount());
        accountBankingServiceImpl.saveAccBank(accountBanking);

        return "OK";
    }

    @PostMapping("/booking/check-promotion")
    @ResponseBody
    public String checkPromotion(@RequestParam long bookingId,
            @RequestParam String code,
            HttpSession session) {
        BookingEntity booking = bookingServiceImpl.getBooking(bookingId);
        PromotionEntity promotionCode = promotionServiceImpl.getCode(code);
        if (promotionCode == null) {
            return "error5";
        }
        if (booking.getCheckin().before(promotionCode.getStartDate())) {
            return "error1";
        } else if (booking.getCheckin().after(promotionCode.getEndDate())) {
            return "error2";
        } else if (promotionCode.getQuantity() < 0) {
            return "error3";
        }
        List<BookingEntity> bookings = bookingServiceImpl.findBookingByEmail(booking.getEmail());
        boolean contain = false;
        if (!bookings.isEmpty()) {
            for (BookingEntity b : bookings) {
                if (b.getCode() != null && b.getCode().equals(code)) {
                    contain = true;
                }
            }
        }
        if (contain) {
            return "error4";
        }
        double total = booking.total() - booking.total() * promotionCode.getDiscount() / 100;
        session.setAttribute("promotionCode", promotionCode);

        return ManagerUtils.formatPrice(total);
    }

    @GetMapping("/booking/invoice-export")
    public void exportToPDF(@RequestParam long id,
            HttpServletResponse response) throws IOException, ParseException {
        response.setContentType("application/pdf");
        DateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");
        String currentDateTime = dateFormatter.format(new Date());

        String headerKey = "Content-Disposition";
        String headerValue = "attachment; filename=invoice_" + currentDateTime + ".pdf";
        response.setHeader(headerKey, headerValue);

        InvoicePDFExporter exporter = new InvoicePDFExporter(bookingServiceImpl.getBooking(id));
        exporter.export(response);

    }

}
