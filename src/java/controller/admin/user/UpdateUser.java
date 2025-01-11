/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.user;

import dal.UserDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

/**
 *
 * @author DAT
 */
@WebServlet(name = "UpdateUser", urlPatterns = {"/admin/cap-nhat-thong-tin-khach-hang"})
public class UpdateUser extends HttpServlet {

    private final UserDao ud = new UserDao();

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
            out.println("<title>Servlet UpdateUser</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateUser at " + request.getContextPath() + "</h1>");
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
        String userId = request.getParameter("ma-khach-hang");
        User u = ud.findUserById(validation.Validate.getInteger(userId));
        if (u != null) {
            request.setAttribute("u", u);
        } else {
            request.setAttribute("error", "Người dùng không tồn tại");
        }
        request.getRequestDispatcher("/dashboard/user/update.jsp").forward(request, response);
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
        String id = request.getParameter("id");
        String nameRequest = request.getParameter("fullName") != null ? request.getParameter("fullName") : "";
        String teleRequest = request.getParameter("telephone") != null ? request.getParameter("telephone") : "";
        String addressRequest = request.getParameter("address") != null ? request.getParameter("address") : "";

        User u = ud.findUserById(validation.Validate.getInteger(id));
        if (u != null) {
            request.setAttribute("u", u);
            if (nameRequest.isEmpty() || teleRequest.isEmpty() || addressRequest.isEmpty() || !validation.Validate.checkTele(teleRequest)) {
                if (nameRequest.isEmpty()) {
                    request.setAttribute("errorFullName", "Họ và tên không thể để trống.");
                }
                if (teleRequest.isEmpty()) {
                    request.setAttribute("errorTel", "Số điện thoại không thể để trống.");
                }
                if (addressRequest.isEmpty()) {
                    request.setAttribute("errorAddress", "Địa không thể để trống.");
                }
                if (!validation.Validate.checkTele(teleRequest)) {
                    request.setAttribute("errorTelFormat", "Số điện thoại phải có từ 10 đến 11 số.");
                }
                request.getRequestDispatcher("/dashboard/user/update.jsp").forward(request, response);
            } else {
                u.setFullName(nameRequest);
                u.setTelephone(teleRequest);
                u.setAddress(addressRequest);
                int rowAffected = ud.update(u);
                if(rowAffected >= 1) {
                    response.sendRedirect("/electro-store/admin/quan-ly-khach-hang");
                }
            }
        }
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
