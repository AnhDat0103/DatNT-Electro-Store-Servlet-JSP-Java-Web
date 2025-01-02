/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package config;

/**
 *
 * @author DAT
 */
public class MyLibrary {

    public static double convertStringToDouble(String s) {
        double a;
        try {
            a = Double.parseDouble(s);
        } catch (NumberFormatException e) {
            a = 0;
        }
        return a;
    }

    public static int convertStringToInteger(String s) {
        int a;
        try {
            a = Integer.parseInt(s);
        } catch (NumberFormatException e) {
            a = 0;
        }
        return a;
    }

}
