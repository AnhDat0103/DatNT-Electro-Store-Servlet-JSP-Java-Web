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
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Product> findAll() {
        String sql = "SELECT * FROM Products";
        List<Product> products = new ArrayList<>();
        BrandDao bd = new BrandDao();
        CategoryDao cd = new CategoryDao();
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
            connection.close();
        } catch (SQLException e) {
        }
        return products;
    }

    @Override
    public void update(Product t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Product t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
