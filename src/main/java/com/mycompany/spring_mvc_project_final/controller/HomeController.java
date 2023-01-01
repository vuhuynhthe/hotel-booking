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

// Trang chủ start
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
            model.addAttribute("message", "Thông tin đăng nhập chưa chính xác!!!");
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
//    Tìm kiếm phòng

    @RequestMapping(value = "/searchroom", method = RequestMethod.POST)
    public String searchRoom(Model model, HttpSession session,
            @RequestParam(name = "datein") Date datein,
            @RequestParam(name = "dateout") Date dateout,
            @RequestParam(name = "categoryId") long categoryId) {
        model.addAttribute("categories", categoryRoomServiceImpl.getCategories());
        //        check ngày khách đặt 
        if (datein.after(dateout)) {
            model.addAttribute("check", "Phiền quý khách nhập lại! Ngày đi phải lớn ngày đến ! Xin cảm ơn !");
            return "home";
        }
        // tính số ngày ở của khách
        long diff = dateout.getTime() - datein.getTime();
        long day = diff / (24 * 60 * 60 * 1000);
        session.setAttribute("day", day);
// lấy ngày checkIn checkOut của khách gưi lên session         
        BookingEntity booking = new BookingEntity();
        if (session.getAttribute("bookingSession") != null) {
            booking = (BookingEntity) session.getAttribute("bookingSession");
        }
        booking.setCheckin(datein);
        booking.setCheckout(dateout);
        session.setAttribute("bookingSession", booking);

//        Kiểm tra 3 dữ liệu lấy về , nếu có hiện thông tin lên trang room
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

    // Xử lý phần tìm kiếm phòng cho khách


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

//    Xử lý search thêm phòng của khách
    @RequestMapping(value = "/search-more", method = RequestMethod.POST)
    public String searchMore(Model model, HttpSession session,
            @RequestParam(name = "categoryId") long categoryId) {
        model.addAttribute("categories", categoryRoomServiceImpl.getCategories());
        BookingEntity booking = (BookingEntity) session.getAttribute("bookingSession");
        Set<RoomEntity> rooms = roomServiceImpl.findRoomAvaiable(booking.getCheckin(), booking.getCheckout(), categoryId);

        model.addAttribute("room", rooms);
        return "rooms";
    }

// Trang chi tiết sản phẩm
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

//    / Trang chi tiết xử lý phần bình luân
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
            model.addAttribute("message", "Bạn chỉ được phép bình luận 1 lần");
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

// Lấy thông tin của khách booking đẩy lên session
    @RequestMapping(value = "/checked", method = RequestMethod.POST)
    public String checkRoom(Model model, HttpSession session) {

        BookingEntity booking = (BookingEntity) session.getAttribute("bookingSession");
        double total = HomeUtils.getTotal(booking);
        model.addAttribute("total", total);
// đẩy thông tin account lên session, xử lý khách hàng đã đăng nhập
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }
        AccountEntity acc = accountServiceImpl.getAccount(username);

        session.setAttribute("acc", acc);
//        Lấy id dịch vụ set vào serviceBooking.

        return "bookinginfo";
    }
// Trang điền thông tin khách hàng sau khi xác nhận đặt phòng

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
//        check 4 trường hợp tồn tại mã code
//        Trường hợp chua login va nhap ma code
        String tinnhan = "";
        if (code != null && !code.isEmpty()) {

            PromotionEntity promotionCode = promotionServiceImpl.getCode(code);
            if (promotionCode == null) {
                tinnhan = "Mã không tồn tại !!";
            } else {
                if (booking.getCheckin().before(promotionCode.getStartDate())) {
                    tinnhan = "Mã chưa được áp dụng !!";
                } else if (booking.getCheckin().after(promotionCode.getEndDate())) {
                    tinnhan = "Mã hết hạn sử dụng !!";
                } else if (promotionCode.getQuantity() <= 0) {
                    tinnhan = "Số lượng mã khuyến mãi đã hết !!";
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
                        tinnhan = "Mã đã được sử dụng !!";
                    } else {
                        tinnhan = "Áp dụng mã thành công !!";
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
        //            Trường hợp Chua login va ko nhap ma code
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
//         trường hợp đăng nhập và chưa nhập code
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
// Trang thanh toán sau khi điền thông tin khách hàng

    @RequestMapping(value = "/payment", method = RequestMethod.POST)
    public String payment(Model model, HttpSession session,
            @RequestParam(name = "cardNumber") String cardNumber) {
        model.addAttribute("categories", categoryRoomServiceImpl.getCategories());
        model.addAttribute("feed", feedBackServiceImpl.getFeedBack());
//        Lấy dữ liệu trên session để luu vào data
        BookingEntity booking = (BookingEntity) session.getAttribute("bookingSession");
        double total = HomeUtils.getTotal(booking);
        AccountBankingEntity accbank = accountBankingServiceImpl.getAccountBankingByCartNumber(cardNumber);
        if (accbank != null && accbank.getBalance() > total) {
            double price = 0;
            price = accbank.getBalance() - total;
            accbank.setBalance(price);
            accountBankingServiceImpl.saveAccBank(accbank);

            bookingServiceImpl.addBooking(booking);

            model.addAttribute("tinnhan", "Bạn đã booking thành công ! Hãy kiểm tra Email của bạn !!");
            EmailService.sendSimpleMessage(booking.getEmail(), "Hotel", "Bạn đã đặt phòng thành công !!!");
            session.removeAttribute("bookingSession");
            session.removeAttribute("roomId");
            return "successful";
        } else {
            model.addAttribute("tinnhan", "Bạn đã nhập tài khoản chưa chính xác hoặc tiền trong tài khoản của bạn không đủ để thực hiện giao dịch ! Hãy kiểm tra lại !");
            model.addAttribute("total", total);
            return "payment";
        }
    }

// Hiển thị trang đăng ký 
    @RequestMapping("/register")
    public String displayRegister(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || authentication instanceof AnonymousAuthenticationToken) {
            return "register";
        }

        return "redirect:/";

    }
// Trang Đăng Ký tài khoản khách hàng start

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
            model.addAttribute("loinhan", "Email bạn nhập đã tồn tại !!! phiền bạn nhập Email khác !");
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
        model.addAttribute("loinhan", "Bạn đã đăng ký thành công !!");
        return "home";
    }
// Đăng Ký tài khoản khách hàng end

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
//    Hiển thị trang Lịch sử booking

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
// Trang setting tài khoản

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
// Xử lý lưu account 

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String updateAcount(Model model,
            @ModelAttribute("account") AccountEntity account) {
        account.setUserRoles(roleServiceImpl.getRoles(account.getEmail()));
        accountServiceImpl.saveAccount(account);
        return "redirect:/setting";
    }
// send-mail khi đổi mật khẩu

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
