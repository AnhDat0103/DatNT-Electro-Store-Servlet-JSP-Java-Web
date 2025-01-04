/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import config.MyLibrary;
import dal.BrandDao;
import dal.CategoryDao;
import dal.ProductDao;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import model.Brand;
import model.Product;


/**
 *
 * @author DAT
 */
@WebServlet(name = "CreateProduct", urlPatterns = {"/admin/tao-moi-san-pham"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 50, // 50MB
    maxRequestSize = 1024 * 1024 * 50)
public class CreateProduct extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final BrandDao bd = new BrandDao();
    private final CategoryDao cd = new CategoryDao();
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
            out.println("<title>Servlet CreateProduct</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateProduct at " + request.getContextPath() + "</h1>");
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
        List<Brand> bs = bd.findAll();
        HttpSession session = request.getSession();
        if (!bs.isEmpty()) {
            session.setAttribute("brands", bs);
        }
        request.getRequestDispatcher("/dashboard/product/create.jsp").forward(request, response);
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
        String name = request.getParameter("name") != null ? request.getParameter("name") : "";
        String priceRequest = request.getParameter("price") != null ? request.getParameter("price") : "";
        String quantityRequest = request.getParameter("quantity") != null ? request.getParameter("quantity") : "";
        String description = request.getParameter("description") != null ? request.getParameter("description") : "";
        String brandRequest = request.getParameter("brand") != null ? request.getParameter("brand") : "";
        String categoryRequest = request.getParameter("inlineRadioOptions") != null ? request.getParameter("inlineRadioOptions") : "";

        String image = uploadFile(request, response);

        if (name.isEmpty() || priceRequest.isEmpty() || quantityRequest.isEmpty()
                || description.isEmpty() || brandRequest.isEmpty()
                || categoryRequest.isEmpty() || image == null || image.isEmpty()) {
            if (name.isEmpty()) {
                request.setAttribute("nameError", "Tên sản phẩm không thể để trống.");
            }
            if (description.isEmpty()) {
                request.setAttribute("desError", "Miêu tả sản phẩm không thể để trống.");
            }

            if (priceRequest.isEmpty()) {
                request.setAttribute("emptyError", "không được để trống.");
            }
            if (quantityRequest.isEmpty()) {
                request.setAttribute("emptyError", "không được để trống.");
            }
            if (image == null || image.isEmpty()) {
                request.setAttribute("imgError", "Ảnh sản phẩm không thể để trống.");
            }

            request.getRequestDispatcher("/dashboard/product/create.jsp").forward(request, response);

        } else {
            double price = MyLibrary.convertStringToDouble(priceRequest);
            int quantity = MyLibrary.convertStringToInteger(quantityRequest);
            int brandId = MyLibrary.convertStringToInteger(brandRequest);
            if (price > 0 && quantity > 0) {
                int categoryId = getCategoryId(categoryRequest);
                Product p = new Product();
                p.setName(name);
                p.setPrice(price);
                p.setQuantity(quantity);
                p.setDescription(description);
                p.setBrand(bd.findBrandById(brandId));
                p.setCategory(cd.findCategoryById(categoryId));
                p.setImage(image);
                pd.save(p);
                request.setAttribute("successMessage", "Sản phẩm đã được tạo thành công.");
                request.getRequestDispatcher("/dashboard/product/create.jsp").forward(request, response);
            } else {
                if (price <= 0) {
                    request.setAttribute("errorPrice", "Số tiền phải lớn hơn 0đ.");
                }
                if (quantity <= 0) {
                    request.setAttribute("errorQuantity", "Số lượng  phải lớn hơn 0.");
                }
                request.getRequestDispatcher("/dashboard/product/create.jsp").forward(request, response);
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

    public int getCategoryId(String option) {
        int categoryId = 0;
        switch (option) {
            case "option1":
                categoryId = 1;
                break;
            case "option2":
                categoryId = 2;
                break;
            case "option3":
                categoryId = 3;
                break;
        }
        return categoryId;
    }

    public String uploadFile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fileName;
        String uploadPath = "D:\\DAT\\Documents\\FPT University\\Semester 04\\PRJ301\\Assignment-Project\\ShopBanDoDienTu\\web\\resources\\admin\\img";
        File uploadDir = new File(uploadPath);
        if(!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        Part filePart = request.getPart("fileImage");
        if(filePart != null && filePart.getSize() > 0) {
            fileName = getFileName(filePart);
            String filePath = uploadPath + File.separator + fileName;
            File existingFile = new File(filePath);
            if (existingFile.exists() && !existingFile.delete()) {
                throw new IOException("Failed to overwrite existing file: " + filePath);
            }
            filePart.write(filePath);
            return fileName;
        }
        return null;
    }

    private String getFileName(Part filePart) {
        for (String content : filePart.getHeader("content-disposition").split(";")) {
            if(content.trim().startsWith("filename")){
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return null;
    }

}
