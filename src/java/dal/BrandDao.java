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
import model.Brand;

/**
 *
 * @author DAT
 */
public class BrandDao extends DBConnect implements Dao<Brand> {

    @Override
    public void save(Brand t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Brand> findAll() {
        String sql = "SELECT * FROM Brands";
        List<Brand> brands = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Brand b = new Brand(rs.getInt("brand_id"), rs.getString("name"), rs.getString("country"));
                brands.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return brands;
    }

    @Override
    public void update(Brand t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Brand t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public Brand findBrandById(int id) {
        Brand brand = null;
        String sql = "SELECT * FROM Brands WHERE brand_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                brand = new Brand(rs.getInt("brand_id"), rs.getString("name"), rs.getString("country"));
            }
            connection.close();
        } catch (SQLException e) {
        }
        return brand;
    }

}
