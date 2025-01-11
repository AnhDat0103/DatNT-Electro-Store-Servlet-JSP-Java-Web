/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin.user;

import dal.RoleDao;
import dal.UserDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import model.dto.RegisterNewUser;
import validation.Validate;

/**
 *
 * @author DAT
 */
@WebServlet(name="CreateNewUser", urlPatterns={"/admin/tao-moi-khach-hang"})
public class CreateNewUser extends HttpServlet {
    
        private final UserDao userDao = new UserDao();
        private final RoleDao rd = new RoleDao();
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CreateNewUser</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateNewUser at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("/dashboard/user/create.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String firstName = request.getParameter("firstName") != null ? request.getParameter("firstName") : "";
        String lastName = request.getParameter("lastName") != null ? request.getParameter("lastName") : "";
        String email = request.getParameter("email") != null ? request.getParameter("email") : "";
        String telephone = request.getParameter("telephone") != null ? request.getParameter("telephone") : "";
        String password = request.getParameter("pass") != null ? request.getParameter("pass") : "";
        String confirmPassword = request.getParameter("confirPass") != null ? request.getParameter("confirPass") : "";
        String address = request.getParameter("address") != null ? request.getParameter("address") : "";
        String role = request.getParameter("role_id") != null ? request.getParameter("role_id") : "";
        
        if (!lastName.isEmpty() && !email.isEmpty() && !password.isEmpty() && !confirmPassword.isEmpty()
                && !role.isEmpty() && !telephone.isEmpty() && !address.isEmpty()
                && !Validate.emailIsExist(email) && Validate.checkEmail(email)
                && Validate.checkConfirmPassword(password, confirmPassword)
                && Validate.checkTele(telephone)) {
            RegisterNewUser rnu = new RegisterNewUser(firstName, lastName, email, telephone, password, confirmPassword, address, getRole(role));
            User user = convertToUser(rnu);
            userDao.save(user);
            response.sendRedirect("/electro-store/admin/quan-ly-khach-hang");
        } else {
            if (lastName.isEmpty()) {
                request.setAttribute("errorFirstName", "Tên không thể để trống.");
            }
            if (!Validate.checkEmail(email)) {
                request.setAttribute("errorEmailFormat", "Email không đúng định dạng.");
            }
            if (Validate.emailIsExist(email)) {
                request.setAttribute("errorEmailExist", "Email đã được đăng ký. Hãy dùng email khác.");
            }
            if (!Validate.checkConfirmPassword(password, confirmPassword)) {
                request.setAttribute("errorPass", "Mật khẩu chưa chính xác.");
            }
            if (password.isEmpty()) {
                request.setAttribute("errorPass2", "Mật khẩu không thể để trống.");
            }
            if(telephone.isEmpty()) {
                request.setAttribute("errorTel", "Số điện thoại không thể dể trống");
            }
            if(address.isEmpty()) {
                request.setAttribute("errorAddress", "Vui lòng nhập địa chỉ.");
            }
            if(!Validate.checkTele(telephone)) {
                request.setAttribute("errorTelFormat", "Số điện thoại phải có từ 10 đến 11 số.");
            }
            request.getRequestDispatcher("/dashboard/user/create.jsp").forward(request, response);
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
    
    public int getRole(String roleId){
        int role;
        switch (roleId) {
            case "1" -> role = 1;
            case "2" -> role = 2;
            default -> role = 0;
        }
        return role;
    }

    private User convertToUser(RegisterNewUser rnu) {
         User u = new User();
        u.setFullName(rnu.getFirstName() + " " + rnu.getLastName());
        u.setEmail(rnu.getEmail());
        u.setTelephone(rnu.getTelephone());
        u.setPassword(rnu.getPassword());
        u.setAddress(rnu.getAddress());
        u.setRole(rd.findRoleById(rnu.getRoleId()));
        return u;
    }

}
