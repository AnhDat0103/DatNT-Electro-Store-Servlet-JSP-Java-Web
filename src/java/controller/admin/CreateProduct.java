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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Brand;
import model.Product;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author DAT
 */
@WebServlet(name = "CreateProduct", urlPatterns = {"/admin/tao-moi-san-pham"})
@MultipartConfig
public class CreateProduct extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final int MEMORY_THRESHOLD = 1024 * 1024;
    private static final long MAX_FILE_SIZE = 1024 * 1024 * 5;
    private static final long MAX_REQUEST_SIZE = 1024 * 1024 * 5 * 5;
    
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
                uploadFile(request, response);
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

    public String uploadFile(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        if (!isMultipart) {
            return null;
        }

        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setFileSizeMax(MAX_FILE_SIZE);
        upload.setSizeMax(MAX_REQUEST_SIZE);

        String uploadPath = getServletContext().getRealPath("") + File.separator + "resources" + File.separator + "admin" + File.separator + "img";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        String fileName = null;
        List<FileItem> formItems = null;
        try {
            formItems = upload.parseRequest(request);
        } catch (FileUploadException ex) {
            Logger.getLogger(CreateProduct.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (formItems != null && !formItems.isEmpty()) {
            for (FileItem item : formItems) {
                if (!item.isFormField()) {
                    fileName = new File(item.getName()).getName();
                    String filePath = uploadPath + File.separator + fileName;
                    File storeFile = new File(filePath);
                    try {
                        item.write(storeFile);
                    } catch (Exception ex) {
                        Logger.getLogger(CreateProduct.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
        }
        return fileName;
    }

}
