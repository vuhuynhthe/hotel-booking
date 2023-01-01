/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.spring_mvc_project_final.controller;

import com.mycompany.spring_mvc_project_final.entities.AccountEntity;
import com.mycompany.spring_mvc_project_final.entities.RoleEntity;
import com.mycompany.spring_mvc_project_final.enums.Role;
import com.mycompany.spring_mvc_project_final.enums.UserStatus;
import com.mycompany.spring_mvc_project_final.service.AccountServiceImpl;
import com.mycompany.spring_mvc_project_final.service.RoleServiceImpl;
import com.mycompany.spring_mvc_project_final.utils.AdminUtils;
import com.mycompany.spring_mvc_project_final.utils.ManagerUtils;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AccountServiceImpl accountServiceImpl;

    @Autowired
    private RoleServiceImpl roleServiceImpl;

    // 1.Home admin
    @RequestMapping("/home")
    public String viewHome(Model model) {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }

        model.addAttribute("username", username);
        return "admin/home";
    }

    // 2.View and manage account
    @RequestMapping("/view")
    public String viewAccounts(Model model,
            @RequestParam(name = "page", required = false, defaultValue = "0") int page,
            @RequestParam(name = "size", required = false, defaultValue = "10") int size) {
        List<AccountEntity> listAccount = accountServiceImpl.getAccounts(page, size);
        int pages = 0;
        if (accountServiceImpl.getAccounts().size() > size) {
            pages = ManagerUtils.getPages(accountServiceImpl.getAccounts().size(), size);
        }
        model.addAttribute("pages", pages);
        model.addAttribute("listAccount", listAccount);
        model.addAttribute("page", page);
        model.addAttribute("size", size);
        model.addAttribute("statuses", UserStatus.values());

        return "admin/accounts";
    }

    @ResponseBody
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addAcount(Model model,
            @ModelAttribute("account") AccountEntity account) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        account.setPassword(encoder.encode(account.getPassword()));
        if (accountServiceImpl.addAccount(account)) {
            return "OK";
        }

        return "Registration failed, email is already in use!";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String updateAcount(Model model,
            @ModelAttribute("account") AccountEntity account) {
        account.setUserRoles(roleServiceImpl.getRoles(account.getEmail()));
        accountServiceImpl.updateAccount(account);

        return "redirect:/admin/view";
    }

    @GetMapping("/delete-account")
    public String deleteRoomCategory(@RequestParam long id) {
        accountServiceImpl.deleteAccount(id);

        return "redirect:/admin/view";
    }

    @RequestMapping("/search-by-key")
    @ResponseBody
    public String searchByName(HttpServletRequest servletRequest,
            @RequestParam(required = false) String name,
            @RequestParam(required = false) String email,
            @RequestParam(required = false) String action) throws ParseException {
        StringBuffer url = servletRequest.getRequestURL();
        String uri = servletRequest.getRequestURI();
        String ctx = servletRequest.getContextPath();
        String base = url.substring(0, url.length() - uri.length() + ctx.length()) + "/admin/delete-account";
        List<AccountEntity> listAccount = new ArrayList<>();
        if (name != null) {
            listAccount = accountServiceImpl.findByName(name);
        }

        if (!email.isEmpty()) {
            listAccount = accountServiceImpl.findByEmail(email);
        }

        String html = "";
        for (int i = 0; i < listAccount.size(); i++) {

            String gender = "";
            if (!listAccount.get(i).isGender()) {
                gender = "Male";
            } else {
                gender = "Female";
            }

            if (action == null) {
                html += "<tr>";
                html += "<td>" + (i + 1) + "</td>";
                html += "<td>" + listAccount.get(i).getName() + "</td>";
                html += "<td>" + listAccount.get(i).getEmail() + "</td>";
                html += "<td>" + gender + "</td>";
                html += "<td>" + ManagerUtils.loadDate(listAccount.get(i).getBirthDate()) + "</td>";
                html += "<td>" + ManagerUtils.loadDateTime(listAccount.get(i).getCreateDate()) + "</td>";
                html += "<td>" + listAccount.get(i).getStatus() + "</td>";
                html += "<td>" + listAccount.get(i).getUserRoles().iterator().next().getRole() + "</td>";
                html += "<td>";
                html += "<button class=\"badge badge-pill badge-primary\" id=\"btnFormEdit" + listAccount.get(i).getId() + "\" data-toggle=\"modal\" data-target=\"#formEdit" + listAccount.get(i).getId() + "\" ><i class=\"fas fa-pencil-alt m-r-5\"></i> Edit</button>";
                if (!AdminUtils.checkContainsRoleAdmin(listAccount.get(i).getUserRoles()) && listAccount.get(i).getBookings().isEmpty()) {
                    html += "<a class=\"badge badge-danger\" href=\"" + base + "?id=" + listAccount.get(i).getId() + "\" onclick=\"return confirm('Are you sure you want to delete this item?');\"><i class=\"fas fa-trash-alt m-r-5\"></i> Delete</a>";
                }
                html += "</td>";
                html += "</tr>";
            } else {
                html += "<tr>";
                html += "<td>" + (i + 1) + "</td>";
                html += "<td>" + listAccount.get(i).getName() + "</td>";
                html += "<td>" + listAccount.get(i).getEmail() + "</td>";

                html += "<td>";
                if (AdminUtils.checkContainsRoleAdmin(listAccount.get(i).getUserRoles())) {
                    html += "<input type=\"checkbox\" name=\"roleAdmin\"  id=\"roleAdmin" + listAccount.get(i).getId() + "\" checked=\"\">";
                } else {
                    html += "<input type=\"checkbox\" name=\"roleAdmin\" id=\"roleAdmin" + listAccount.get(i).getId() + "\">";
                }
                html += "</td>";

                html += "<td>";
                if (AdminUtils.checkContainsRoleManager(listAccount.get(i).getUserRoles())) {
                    html += "<input type=\"checkbox\" name=\"roleManager\" id=\"roleManager" + listAccount.get(i).getId() + "\" checked=\"\">";
                } else {
                    html += "<input type=\"checkbox\" name=\"roleManager\" id=\"roleManager" + listAccount.get(i).getId() + "\">";
                }
                html += "</td>";

                html += "<td>";
                if (AdminUtils.checkContainsRoleReciption(listAccount.get(i).getUserRoles())) {
                    html += "<input type=\"checkbox\" name=\"roleReciption\" id=\"roleReciption" + listAccount.get(i).getId() + "\" checked=\"\">";
                } else {
                    html += "<input type=\"checkbox\" name=\"roleReciption\" id=\"roleReciption" + listAccount.get(i).getId() + "\">";
                }
                html += "</td>";

                html += "<td>";
                if (AdminUtils.checkContainsRoleUser(listAccount.get(i).getUserRoles())) {
                    html += "<input type=\"checkbox\" name=\"roleUser\" id=\"roleUser" + listAccount.get(i).getId() + "\" checked=\"\">";
                } else {
                    html += "<input type=\"checkbox\" name=\"roleUser\" id=\"roleUser" + listAccount.get(i).getId() + "\">";
                }
                html += "</td>";

                html += "<td>";
                html += "<button type=\"submit\" onclick=\"setRole(" + listAccount.get(i).getId() + ")\"><i class=\"fas fa-wallet m-r-5\"></i>Save</button>";
                html += "</td>";
                html += "</tr>";
            }
        }

        return html;
    }

    // 3.View and decentralization account
    @RequestMapping("/decentralization")
    public String decentralization(Model model,
            @RequestParam(name = "page", required = false, defaultValue = "0") int page,
            @RequestParam(name = "size", required = false, defaultValue = "10") int size) {
        List<AccountEntity> listAccount = accountServiceImpl.getAccounts(page, size);
        int pages = 0;
        if (accountServiceImpl.getAccounts().size() > size) {
            pages = ManagerUtils.getPages(accountServiceImpl.getAccounts().size(), size);
        }
        model.addAttribute("pages", pages);
        model.addAttribute("listAccount", listAccount);
        model.addAttribute("page", page);
        model.addAttribute("size", size);
        model.addAttribute("roleAdmin", Role.ROLE_ADMIN);
        model.addAttribute("roleManager", Role.ROLE_MANAGER);
        model.addAttribute("roleReciption", Role.ROLE_RECIPTION);
        model.addAttribute("roleUser", Role.ROLE_USER);

        return "admin/decentralization";
    }

    @PostMapping("/set-role")
    public String submitSetRole(@RequestParam long id,
            @RequestParam(required = false) boolean roleAdmin,
            @RequestParam(required = false) boolean roleManager,
            @RequestParam(required = false) boolean roleReciption,
            @RequestParam(required = false) boolean roleUser) {
        AccountEntity account = accountServiceImpl.getAccount(id);
        Set<RoleEntity> roles = account.getUserRoles();
        roles.clear();

        if (roleAdmin) {
            roles.add(AdminUtils.getRoleAdmin());
        }

        if (roleManager) {
            roles.add(AdminUtils.getRoleManager());
        }

        if (roleReciption) {
            roles.add(AdminUtils.getRoleReciption());
        }

        if (roleUser) {
            roles.add(AdminUtils.getRoleUser());
        }

        accountServiceImpl.updateAccount(account);

        return "redirect:/admin/decentralization";
    }

    @GetMapping("/set-role")
    public String submitSetRoleSearch(long id,
            @RequestParam(required = false) boolean roleAdmin,
            @RequestParam(required = false) boolean roleManager,
            @RequestParam(required = false) boolean roleReciption,
            @RequestParam(required = false) boolean roleUser) {

        return submitSetRole(id, roleAdmin, roleManager, roleReciption, roleUser);
    }
}
