/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.List;

/**
 *
 * @author DAT
 * @param <T>
 */
public interface Dao <T> {
    
    
    public void save(T t);
    
    public List<T> findAll();
    
    public int update(T t);
    
    public void delete(T t);
    
}
