/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;

/**
 *
 * @author DAT
 */
public class ProductDao extends DBConnect implements Dao<Product> {

    private CategoryDao cd = new CategoryDao();
    private BrandDao bd = new BrandDao();

    @Override
    public void save(Product t) {
        String sql = "INSERT INTO [dbo].[Products]\n"
                + "           ([name]\n"
                + "           ,[price]\n"
                + "           ,[quantity]\n"
                + "           ,[category_id]\n"
                + "           ,[brand_id]\n"
                + "           ,[description]\n"
                + "           ,[image])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, t.getName());
            ps.setDouble(2, t.getPrice());
            ps.setInt(3, t.getQuantity());
            ps.setInt(4, t.getCategory().getId());
            ps.setInt(5, t.getBrand().getId());
            ps.setString(6, t.getDescription());
            ps.setString(7, t.getImage());
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Product> findAll() {
        String sql = "SELECT * FROM Products";
        List<Product> products = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("product_id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                p.setDescription(rs.getString("description"));
                p.setImage(rs.getString("image"));
                p.setBrand(bd.findBrandById(rs.getInt("brand_id")));
                p.setCategory(cd.findCategoryById(rs.getInt("category_id")));
                products.add(p);
            }
        } catch (SQLException e) {
        }
        return products;
    }

    @Override
    public int update(Product t) {
        String sql = "UPDATE [dbo].[Products]\n"
                + "   SET [name] = ?\n"
                + "      ,[price] = ?\n"
                + "      ,[quantity] = ?\n"
                + "      ,[category_id] = ?\n"
                + "      ,[brand_id] = ?\n"
                + "      ,[description] = ?\n"
                + "      ,[image] = ?\n"
                + " WHERE product_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, t.getName());
            ps.setDouble(2, t.getPrice());
            ps.setInt(3, t.getQuantity());
            ps.setInt(4, t.getCategory().getId());
            ps.setInt(5, t.getBrand().getId());
            ps.setString(6, t.getDescription());
            ps.setString(7, t.getImage());
            ps.setInt(8, t.getId());
            int rs = ps.executeUpdate();
            return rs;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
        
    }

    @Override
    public void delete(Product t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public Product findProductById(int productId) {
        String sql = "SELECT * FROM Products WHERE product_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Product p = new Product(rs.getInt("product_id"), rs.getString("name"),
                        rs.getDouble("price"), rs.getInt("quantity"),
                        rs.getString("description"), rs.getString("image"),
                        cd.findCategoryById(rs.getInt("category_id")),
                        bd.findBrandById(rs.getInt("brand_id"))
                );
                return p;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean deleteProduct(int productId) {
        boolean flag;
        String sql = "DELETE FROM Products WHERE product_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            flag = false;
        }
        return flag;
    }

}
