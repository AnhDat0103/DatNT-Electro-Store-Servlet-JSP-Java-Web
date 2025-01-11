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
        } catch (SQLException e) {
             e.printStackTrace(); 
        }
    }
    public void saveForRegister(User t) {
        String sql = "INSERT INTO [dbo].[Users]\n"
                + "           ([full_name]\n"
                + "           ,[email]\n"
                + "           ,[password]\n"
                + "           ,[role_id])\n"
                + "     VALUES\n"
                + "           (?,?,?,?)";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, t.getFullName());
            ps.setString(2, t.getEmail());
            ps.setString(3, t.getPassword());
            ps.setInt(4, roleDao.findRoleByName("USER"));
            ps.executeUpdate();
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
        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return users;
    }

    @Override
    public int update(User t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int delete(int id) {
        int rowsAffected;
        String sql = "DELETE FROM Users WHERE user_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rowsAffected = ps.executeUpdate();
            return rowsAffected;
        } catch (SQLException e) {
            rowsAffected = 0;
        }
        return rowsAffected;
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
                return currentUser;
            }
        } catch (SQLException e) {
            e.printStackTrace(); 

        }
        return null;
    }
    
    public User findUserByEmail(String email){
        User currentUser = null;
        String sql = "SELECT * FROM Users WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                currentUser = new User(rs.getInt("user_id"),
                        rs.getString("full_name"),
                        rs.getString("email"), 
                        rs.getString("password"),
                        rs.getString("telephone"), 
                        rs.getString("address"), 
                        roleDao.findRoleById(rs.getInt("role_id")));
                return currentUser;
            }
        } catch (SQLException e) {
            e.printStackTrace(); 
        }
        return null;
    }

    public int getTotalRecords() {
        int totalRecords = 0;
        String sql  = "SELECT COUNT(*) FROM Users WHERE role_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, 2);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                totalRecords = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalRecords;
    }

    public List<User> getListUsers(int page, int pageSize) {
        List<User> users = new ArrayList<>();
        int startRecord = (page - 1) * pageSize;
        String sql = "SELECT * FROM Users WHERE role_id = ? ORDER BY user_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, 2);
            ps.setInt(2, startRecord);
            ps.setInt(3, pageSize);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                User u = new User(rs.getInt("user_id"), 
                        rs.getString("full_name"), 
                        rs.getString("email"), 
                        rs.getString("password"), 
                        rs.getString("telephone"), 
                        rs.getString("address"), 
                        roleDao.findRoleById(rs.getInt("role_id")));
                users.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return  users;
    }

    public User findUserById(int parseInt) {
        String sql = "SELECT * FROM Users WHERE user_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, parseInt);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                User u = new User(rs.getInt("user_id"), 
                        rs.getString("full_name"), 
                        rs.getString("email"), 
                        rs.getString("password"), 
                        rs.getString("telephone"), 
                        rs.getString("address"), 
                        roleDao.findRoleById(rs.getInt("role_id")));
                return u;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
