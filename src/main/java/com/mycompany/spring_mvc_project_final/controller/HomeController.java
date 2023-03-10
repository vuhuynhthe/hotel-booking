/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.AccountBankingEntity;
import com.mycompany.spring_mvc_project_final.entities.AccountEntity;
import com.mycompany.spring_mvc_project_final.entities.BookingDetailEntity;
import com.mycompany.spring_mvc_project_final.entities.BookingEntity;
import com.mycompany.spring_mvc_project_final.entities.FeedbackEntity;
import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import com.mycompany.spring_mvc_project_final.entities.RoomEntity;
import com.mycompany.spring_mvc_project_final.service.AccountBankingServiceImpl;
import com.mycompany.spring_mvc_project_final.service.AccountServiceImpl;
import com.mycompany.spring_mvc_project_final.service.BookingDetailServiceImpl;
import com.mycompany.spring_mvc_project_final.service.BookingServiceImpl;
import com.mycompany.spring_mvc_project_final.service.CategoryRoomServiceImpl;
import com.mycompany.spring_mvc_project_final.service.EmailService;
import com.mycompany.spring_mvc_project_final.service.FeedBackServiceImpl;
import com.mycompany.spring_mvc_project_final.service.ImageServiceImpl;
import com.mycompany.spring_mvc_project_final.service.PromotionServiceImpl;
import com.mycompany.spring_mvc_project_final.service.RoleServiceImpl;
import com.mycompany.spring_mvc_project_final.service.RoomServiceImpl;
import com.mycompany.spring_mvc_project_final.service.ServiceBookingServiceImpl;
import com.mycompany.spring_mvc_project_final.service.ServiceServiceImpl;
import com.mycompany.spring_mvc_project_final.utils.HomeUtils;
import com.mycompany.spring_mvc_project_final.utils.ManagerUtils;
import com.mycompany.spring_mvc_project_final.utils.SecurityUtils;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeController {

    @Autowired
    private AccountServiceImpl accountServiceImpl;

    @Autowired
    private RoleServiceImpl roleServiceImpl;

    @Autowired
    private EmailService EmailService;

    @Autowired
    private ImageServiceImpl imageServiceImpl;

    @Autowired
    private CategoryRoomServiceImpl categoryRoomServiceImpl;

    @Autowired
    private FeedBackServiceImpl feedBackServiceImpl;

    @Autowired
    private BookingServiceImpl bookingServiceImpl;

    @Autowired
    private PromotionServiceImpl promotionServiceImpl;

    @Autowired
    private AccountBankingServiceImpl accountBankingServiceImpl;

    @Autowired
    private BookingDetailServiceImpl bookingDetailServiceImpl;

    @Autowired
    private RoomServiceImpl roomServiceImpl;

    @Autowired
    private ServiceServiceImpl serviceServiceImpl;

    @Autowired
    private ServiceBookingServiceImpl serviceBookingServiceImpl;

// Trang ch??? start
    @RequestMapping(value = {"/", "/home"}, method = RequestMethod.GET)
    public String welcomePage(Model model, HttpSession session) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        AccountEntity acc = accountServiceImpl.getAccount(username);
        session.setAttribute("acc", acc);
        model.addAttribute("categories", categoryRoomServiceImpl.getCategories());
        model.addAttribute("feed", feedBackServiceImpl.getTop5());

        List<String> roles = SecurityUtils.getRolesOfUser();
        if (!CollectionUtils.isEmpty(roles) && (roles.contains("ROLE_ADMIN"))) {
            return "redirect:/admin/home";
        } else if (!CollectionUtils.isEmpty(roles) && (roles.contains("ROLE_MANAGER"))) {
            return "redirect:/manager/home";
        }
        return "home";
    }
// Trang login

    @RequestMapping("/login")
    public String loginPage(Model model, @RequestParam(value = "error", required = false) boolean error) {
        if (error) {
            model.addAttribute("message", "Th??ng tin ????ng nh???p ch??a ch??nh x??c!!!");
        }
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || authentication instanceof AnonymousAuthenticationToken) {
            return "login";
        }

        return "redirect:/";
    }

    @RequestMapping("/403")
    public String accessDenied(Model model) {
        return "403Page";
    }
//    T??m ki???m ph??ng

    @RequestMapping(value = "/searchroom", method = RequestMethod.POST)
    public String searchRoom(Model model, HttpSession session,
            @RequestParam(name = "datein") Date datein,
            @RequestParam(name = "dateout") Date dateout,
            @RequestParam(name = "categoryId") long categoryId) {
        model.addAttribute("categories", categoryRoomServiceImpl.getCategories());
        //        check ng??y kh??ch ?????t 
        if (datein.after(dateout)) {
            model.addAttribute("check", "Phi???n qu?? kh??ch nh???p l???i! Ng??y ??i ph???i l???n ng??y ?????n ! Xin c???m ??n !");
            return "home";
        }
        // t??nh s??? ng??y ??? c???a kh??ch
        long diff = dateout.getTime() - datein.getTime();
        long day = diff / (24 * 60 * 60 * 1000);
        session.setAttribute("day", day);
// l???y ng??y checkIn checkOut c???a kh??ch g??i l??n session         
        BookingEntity booking = new BookingEntity();
        if (session.getAttribute("bookingSession") != null) {
            booking = (BookingEntity) session.getAttribute("bookingSession");
        }
        booking.setCheckin(datein);
        booking.setCheckout(dateout);
        session.setAttribute("bookingSession", booking);

//        Ki???m tra 3 d??? li???u l???y v??? , n???u c?? hi???n th??ng tin l??n trang room
        Set<RoomEntity> rooms = roomServiceImpl.findRoomAvaiable(datein, dateout, categoryId);
        if (booking != null) {
            List<Long> roomIds = new ArrayList<>();
            for (BookingDetailEntity b : booking.getBookingDetails()) {
                if (b.getRoom().getRoomCategory().getId() == categoryId) {
                    roomIds.add(b.getRoom().getId());
                }
            }
            if (rooms != null && !rooms.isEmpty()) {
                Iterator<RoomEntity> iterRooms = rooms.iterator();
                while (iterRooms.hasNext()) {
                    RoomEntity room = iterRooms.next();
                    for (Long l : roomIds) {
                        if (room.getId() == l) {
                            iterRooms.remove();
                        }
                    }
                }
            }
        }
        model.addAttribute("room", rooms);
        return "rooms";
    }

    // X??? l?? ph???n t??m ki???m ph??ng cho kh??ch


    @RequestMapping("/buy-more")
    public String buyMore(Model model, HttpSession session) {
        BookingEntity booking = (BookingEntity) session.getAttribute("bookingSession");
        if (booking.getBookingDetails() != null && !booking.getBookingDetails().isEmpty()) {
            int size = booking.getBookingDetails().size();
            long categoryId = booking.getBookingDetails().get(size - 1).getRoom().getRoomCategory().getId();
            return searchRoom(model, session, booking.getCheckin(), booking.getCheckout(), categoryId);
        }
        session.removeAttribute("bookingSession");
        session.removeAttribute("roomId");
        return "redirect:/home";
    }

//    X??? l?? search th??m ph??ng c???a kh??ch
    @RequestMapping(value = "/search-more", method = RequestMethod.POST)
    public String searchMore(Model model, HttpSession session,
            @RequestParam(name = "categoryId") long categoryId) {
        model.addAttribute("categories", categoryRoomServiceImpl.getCategories());
        BookingEntity booking = (BookingEntity) session.getAttribute("bookingSession");
        Set<RoomEntity> rooms = roomServiceImpl.findRoomAvaiable(booking.getCheckin(), booking.getCheckout(), categoryId);

        model.addAttribute("room", rooms);
        return "rooms";
    }

// Trang chi ti???t s???n ph???m
    @RequestMapping("/detail-room/{id}")
    public String displayDetailRoom(Model model, HttpSession session,
            @PathVariable("id") long id) {

//        RoomEntity room = roomServiceImpl.getRoom(id);
//        session.setAttribute("detail", room);
        model.addAttribute("roomCategory", categoryRoomServiceImpl.getCategory(id));
        session.setAttribute("id", id);
        model.addAttribute("feed", feedBackServiceImpl.getTop5());
        model.addAttribute("categories", categoryRoomServiceImpl.getCategories());

        return "room-details";
    }

//    / Trang chi ti???t x??? l?? ph???n b??nh lu??n
    @RequestMapping(value = "/comment", method = RequestMethod.POST)
    public String checkComment(Model model, HttpSession session,
            @RequestParam(name = "email") String email,
            @RequestParam(name = "vote") Integer vote,
            @RequestParam(name = "text") String text,
            @RequestParam(name = "name") String name) {
        model.addAttribute("categories", categoryRoomServiceImpl.getCategories());

        List<FeedbackEntity> feedback3 = feedBackServiceImpl.getFeedBack();
        model.addAttribute("feed", feedback3);

        FeedbackEntity feedback = new FeedbackEntity();

        FeedbackEntity feedback1 = feedBackServiceImpl.getEmail(email);
        if (feedback1 != null) {
            long id = (long) session.getAttribute("id");
            model.addAttribute("categories", categoryRoomServiceImpl.getCategories());
            model.addAttribute("roomCategory", categoryRoomServiceImpl.getCategory(id));
            List<FeedbackEntity> feedback2 = feedBackServiceImpl.getFeedBack();
            model.addAttribute("feed", feedback2);
            model.addAttribute("message", "B???n ch??? ???????c ph??p b??nh lu???n 1 l???n");
            return "room-details";
        }

        feedback.setEmail(email);
        feedback.setName(name);
        feedback.setText(text);
        feedback.setVote(vote);
        feedback.setCreateDate(new Date());
        feedBackServiceImpl.save(feedback);
        long id = (long) session.getAttribute("id");
        return "redirect:/detail-room/" + id;
    }

// L???y th??ng tin c???a kh??ch booking ?????y l??n session
    @RequestMapping(value = "/checked", method = RequestMethod.POST)
    public String checkRoom(Model model, HttpSession session) {

        BookingEntity booking = (BookingEntity) session.getAttribute("bookingSession");
        double total = HomeUtils.getTotal(booking);
        model.addAttribute("total", total);
// ?????y th??ng tin account l??n session, x??? l?? kh??ch h??ng ???? ????ng nh???p
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        AccountEntity acc = accountServiceImpl.getAccount(username);

        session.setAttribute("acc", acc);
//        L???y id d???ch v??? set v??o serviceBooking.

        return "bookinginfo";
    }
// Trang ??i???n th??ng tin kh??ch h??ng sau khi x??c nh???n ?????t ph??ng

    @RequestMapping(value = "/bookinged", method = RequestMethod.POST)
    public String result(Model model, HttpSession session,
            @RequestParam(name = "id", required = false) Long id,
            @RequestParam(name = "gender", required = false) boolean gender,
            @RequestParam(name = "name") String name,
            @RequestParam(name = "birthDate", required = false) String birthDate,
            @RequestParam(name = "phoneNumber") String phoneNumber,
            @RequestParam(name = "email") String email,
            @RequestParam(name = "note") String note,
            @RequestParam(name = "code", required = false) String code) throws ParseException {

        BookingEntity booking = (BookingEntity) session.getAttribute("bookingSession");
        double total = HomeUtils.getTotal(booking);
        model.addAttribute("total", total);
        AccountEntity acc = (AccountEntity) session.getAttribute("acc");
//        check 4 tr?????ng h???p t???n t???i m?? code
//        Tr?????ng h???p chua login va nhap ma code
        String tinnhan = "";
        if (code != null && !code.isEmpty()) {

            PromotionEntity promotionCode = promotionServiceImpl.getCode(code);
            if (promotionCode == null) {
                tinnhan = "M?? kh??ng t???n t???i !!";
            } else {
                if (booking.getCheckin().before(promotionCode.getStartDate())) {
                    tinnhan = "M?? ch??a ???????c ??p d???ng !!";
                } else if (booking.getCheckin().after(promotionCode.getEndDate())) {
                    tinnhan = "M?? h???t h???n s??? d???ng !!";
                } else if (promotionCode.getQuantity() <= 0) {
                    tinnhan = "S??? l?????ng m?? khuy???n m??i ???? h???t !!";
                } else {
                    List<BookingEntity> bookings = bookingServiceImpl.findBookingByEmail(email);
                    boolean contain = false;
                    if (!bookings.isEmpty()) {
                        for (BookingEntity b : bookings) {
                            if (b.getCode() != null && b.getCode().equals(code)) {
                                contain = true;
                            }
                        }
                    }
                    if (contain) {
                        tinnhan = "M?? ???? ???????c s??? d???ng !!";
                    } else {
                        tinnhan = "??p d???ng m?? th??nh c??ng !!";
                        total -= total * promotionCode.getDiscount() / 100;
                        promotionCode.setQuantity(promotionCode.getQuantity() - 1);
                        booking.setPromotion(promotionCode);
                        booking.setDiscount(promotionCode.getDiscount());
                        booking.setCode(code);
                        promotionServiceImpl.savePromotion(promotionCode);
                        model.addAttribute("total", total);
                    }
                }

            }
        }
        //            Tr?????ng h???p Chua login va ko nhap ma code
        if (acc == null) {
            booking.setGender(gender);
            booking.setName(name);
            booking.setPhoneNumber(phoneNumber);
            booking.setEmail(email);
            booking.setBirthDate(ManagerUtils.formatDate(birthDate));
            booking.setNote(note);
            session.setAttribute("bookingSession", booking);
            model.addAttribute("tinnhan", tinnhan);
            return "payment";
        }
//         tr?????ng h???p ????ng nh???p v?? ch??a nh???p code
        AccountEntity accId = accountServiceImpl.getAccount(id);
        booking.setAccount((AccountEntity) accId);
        booking.setGender(accId.isGender());
        booking.setName(accId.getName());
        booking.setPhoneNumber(accId.getPhoneNumber());
        booking.setEmail(accId.getEmail());
        booking.setBirthDate(accId.getBirthDate());
        booking.setNote(note);
        session.setAttribute("bookingSession", booking);
        model.addAttribute("tinnhan", tinnhan);
        return "payment";

    }
// Trang thanh to??n sau khi ??i???n th??ng tin kh??ch h??ng

    @RequestMapping(value = "/payment", method = RequestMethod.POST)
    public String payment(Model model, HttpSession session,
            @RequestParam(name = "cardNumber") String cardNumber) {
        model.addAttribute("categories", categoryRoomServiceImpl.getCategories());
        model.addAttribute("feed", feedBackServiceImpl.getFeedBack());
//        L???y d??? li???u tr??n session ????? luu v??o data
        BookingEntity booking = (BookingEntity) session.getAttribute("bookingSession");
        double total = HomeUtils.getTotal(booking);
        AccountBankingEntity accbank = accountBankingServiceImpl.getAccountBankingByCartNumber(cardNumber);
        if (accbank != null && accbank.getBalance() > total) {
            double price = 0;
            price = accbank.getBalance() - total;
            accbank.setBalance(price);
            accountBankingServiceImpl.saveAccBank(accbank);

            bookingServiceImpl.addBooking(booking);

            model.addAttribute("tinnhan", "B???n ???? booking th??nh c??ng ! H??y ki???m tra Email c???a b???n !!");
            EmailService.sendSimpleMessage(booking.getEmail(), "Hotel", "B???n ???? ?????t ph??ng th??nh c??ng !!!");
            session.removeAttribute("bookingSession");
            session.removeAttribute("roomId");
            return "successful";
        } else {
            model.addAttribute("tinnhan", "B???n ???? nh???p t??i kho???n ch??a ch??nh x??c ho???c ti???n trong t??i kho???n c???a b???n kh??ng ????? ????? th???c hi???n giao d???ch ! H??y ki???m tra l???i !");
            model.addAttribute("total", total);
            return "payment";
        }
    }

// Hi???n th??? trang ????ng k?? 
    @RequestMapping("/register")
    public String displayRegister(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || authentication instanceof AnonymousAuthenticationToken) {
            return "register";
        }

        return "redirect:/";

    }
// Trang ????ng K?? t??i kho???n kh??ch h??ng start

    @RequestMapping(value = "/result", method = RequestMethod.POST)
    public String saveNewAccount(Model model,
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            @RequestParam("gender") boolean gender,
            @RequestParam("birthDate") String birthDate,
            @RequestParam("phoneNumber") String phoneNumber) throws ParseException {
        AccountEntity account1 = accountServiceImpl.getAccount(email);
        if (account1 != null) {
            model.addAttribute("loinhan", "Email b???n nh???p ???? t???n t???i !!! phi???n b???n nh???p Email kh??c !");
            return "register";
        }
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        AccountEntity account = new AccountEntity();
        account.setBirthDate(ManagerUtils.formatDate(birthDate));
        account.setGender(gender);
        account.setName(name);
        account.setEmail(email);
        account.setPassword(encoder.encode(password));
        account.setPhoneNumber(phoneNumber);
        accountServiceImpl.saveAccount(account);
        model.addAttribute("categories", categoryRoomServiceImpl.getCategories());
        model.addAttribute("loinhan", "B???n ???? ????ng k?? th??nh c??ng !!");
        return "home";
    }
// ????ng K?? t??i kho???n kh??ch h??ng end

    @RequestMapping("/rooms")
    public String displayRooms(Model model
    ) {
        model.addAttribute("categories", categoryRoomServiceImpl.getCategories());
        model.addAttribute("room", roomServiceImpl.getRooms());
        return "rooms";
    }

    @RequestMapping("/about-us")
    public String displayAboutus() {
        return "about-us";
    }

    @RequestMapping("/room-details")
    public String displayRoomDetails() {
        return "room-details";
    }

    @RequestMapping("/blog-details")
    public String displayBlogDetails() {
        return "blog-details";
    }

    @RequestMapping("/blog")
    public String displayBlog() {
        return "blog";
    }

    @RequestMapping("/contact")
    public String displayContact() {
        return "contact";
    }
//    Hi???n th??? trang L???ch s??? booking

    @RequestMapping("/booking-history")
    public String displayBookingHistory(Model model, HttpSession session) {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        List<BookingEntity> booking = bookingServiceImpl.findBookingByEmail(username);
        model.addAttribute("bookingHistory", booking);
        return "booking-history";
    }
// Trang setting t??i kho???n

    @RequestMapping("/setting")
    public String settingPage(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }

        AccountEntity account = accountServiceImpl.getAccount(username);
        model.addAttribute("account", account);

        return "setting-account";
    }
// X??? l?? l??u account 

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String updateAcount(Model model,
            @ModelAttribute("account") AccountEntity account) {
        account.setUserRoles(roleServiceImpl.getRoles(account.getEmail()));
        accountServiceImpl.saveAccount(account);
        return "redirect:/setting";
    }
// send-mail khi ?????i m???t kh???u

    @PostMapping("/send-email")
    @ResponseBody
    public String sendEmail(HttpServletRequest servletRequest,
            HttpSession session,
            @RequestParam String email) {
        AccountEntity account = accountServiceImpl.getAccount(email);
        session.setAttribute("account", account);
        StringBuffer url = servletRequest.getRequestURL();
        String uri = servletRequest.getRequestURI();
        String ctx = servletRequest.getContextPath();
        String base = url.substring(0, url.length() - uri.length() + ctx.length()) + "/form-change";

        EmailService.sendSimpleMessage(email, "Hotel", "Click here: " + base);

        return "Ban hay kiem tra mail!! Nhan vao link de thay doi mat khau .";
    }

    @GetMapping("/form-change")
    public String changePasswordPage() {

        return "change-password";
    }

    @PostMapping("/change-password")
    @ResponseBody
    public String changPassword(HttpSession session,
            @RequestParam String newPassword,
            @RequestParam String confirmPassword) {

        AccountEntity account = (AccountEntity) session.getAttribute("account");

        if (!HomeUtils.checkTwoPassword(newPassword, confirmPassword)) {
            return "Fail";
        }

        String passLatest = HomeUtils.encodePassword(newPassword);
        account.setPassword(passLatest);
        accountServiceImpl.saveAccount(account);
        session.removeAttribute("account");

        return "Change password successfully!";
    }
}
