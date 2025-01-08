/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UserDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import model.dto.RegisterUser;
import validation.Validate;

/**
 *
 * @author DAT
 */
@WebServlet(name = "Register", urlPatterns = {"/dang-ky"})
public class Register extends HttpServlet {

    private final UserDao userDao = new UserDao();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
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
            out.println("<title>Servlet Register</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Register at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/dashboard/auth/register.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("pass");
        String confirmPassword = request.getParameter("confirPass");

        if (!lastName.isEmpty() && !email.isEmpty() && !password.isEmpty() && !confirmPassword.isEmpty()
                && !Validate.emailIsExist(email) && Validate.checkEmail(email)
                && Validate.checkConfirmPassword(password, confirmPassword)) {
            RegisterUser rUser = new RegisterUser(firstName, lastName, email, password, confirmPassword);
            User user = convertToUser(rUser);
            userDao.saveForRegister(user);
            request.getRequestDispatcher("/dashboard/auth/login.jsp").forward(request, response);
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
            request.getRequestDispatcher("/dashboard/auth/register.jsp").forward(request, response);
        }
    }

    public User convertToUser(RegisterUser rUser) {
        User u = new User();
        u.setFullName(rUser.getFirstName() + " " + rUser.getLastName());
        u.setEmail(rUser.getEmail());
        u.setPassword(rUser.getPassword());
        return u;
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
