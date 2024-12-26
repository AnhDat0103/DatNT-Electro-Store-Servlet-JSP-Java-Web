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
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Role;
import model.User;

/**
 *
 * @author DAT
 */
public class UserDao extends DBConnect implements Dao<User> {

    private final RoleDao roleDao = new RoleDao();

    @Override
    public void save(User t) {
        String sql = "INSERT INTO [dbo].[Users]\n"
                + "           ([full_name]\n"
                + "           ,[email]\n"
                + "           ,[password]\n"
                + "           ,[telephone]\n"
                + "           ,[address]\n"
                + "           ,[role_id])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?)";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, t.getFullName());
            ps.setString(2, t.getEmail());
            ps.setString(3, t.getPassword());
            ps.setString(4, t.getTelephone());
            ps.setString(5, t.getAddress());
            ps.setInt(6, t.getRole().getRoleId());
            ps.executeUpdate();
            ps.close();
            connection.close();
        } catch (SQLException e) {
             e.printStackTrace(); 
        }
    }

    @Override
    public List<User> findAll() {
        String sql = "SELECT [user_id]\n"
                + "      ,[full_name]\n"
                + "      ,[email]\n"
                + "      ,[password]\n"
                + "      ,[telephone]\n"
                + "      ,[address]\n"
                + "      ,[role_id]\n"
                + "  FROM [dbo].[Users]";
        List<User> users = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setTelephone(rs.getString("telephone"));
                user.setAddress(rs.getString("address"));
                Role role = roleDao.findRoleById(rs.getInt("role_id"));
                if (role != null) {
                    user.setRole(role);
                }
                users.add(user);
            }
            connection.close();
            ps.close();
        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return users;
    }

    @Override
    public void update(User t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(User t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    public User findUserByEmailAndPassword(String email, String password){
        User currentUser = null;
        String sql = "SELECT * FROM Users WHERE email = ? AND password = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                currentUser = new User(rs.getInt("user_id"),
                        rs.getString("full_name"),
                        rs.getString("email"), 
                        rs.getString("password"),
                        rs.getString("telephone"), 
                        rs.getString("address"), 
                        roleDao.findRoleById(rs.getInt("role_id")));
                connection.close();
                return currentUser;
            }
        } catch (SQLException e) {
            e.printStackTrace(); 

        }
        return null;
    }

}
