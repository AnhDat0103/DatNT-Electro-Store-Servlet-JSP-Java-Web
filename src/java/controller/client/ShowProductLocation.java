/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.client;

import dal.ProductDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Product;

/**
 *
 * @author DAT
 */
@WebServlet(name = "ShowLaptopLocation", urlPatterns = {"/kho-hang"})
public class ShowProductLocation extends HttpServlet {

    private final ProductDao pd = new ProductDao();

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
            out.println("<title>Servlet ShowLaptopLocation</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ShowLaptopLocation at " + request.getContextPath() + "</h1>");
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
        String categoryRequest = request.getParameter("action") != null ? request.getParameter("action") : "";
        String pageRequest = request.getParameter("trang-so") != null ? request.getParameter("trang-so") : "1";
        int category = 0;
        int page = 1;
        int pageSize = 6;
        int totalRecords;
        List<Product> products = new ArrayList<>();

        if (pageRequest != null) {
            page = Integer.parseInt(pageRequest);
        }

        if (categoryRequest.isEmpty()) {
            products = pd.getListProduct(page, pageSize);
            totalRecords = pd.getTotalRecords();
        } else {
            switch (categoryRequest) {
                case "laptop" ->
                    category = 1;
                case "may-anh" ->
                    category = 2;
                case "phu-kien" ->
                    category = 3;
            }
            totalRecords = pd.getTotalRecordsByCategory(category);
            products = pd.showProductsByCategogy(category, page, pageSize);

        }

        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        if (page > totalPages) {
            page = totalPages;
        }

        if (products.isEmpty()) {
            request.setAttribute("errorMessage", "Không có sản phẩm nào trong kho");
        } else {
            request.setAttribute("action", categoryRequest);
            request.setAttribute("products", products);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
        }

        request.getRequestDispatcher("product_location.jsp").forward(request, response);
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
        processRequest(request, response);
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
