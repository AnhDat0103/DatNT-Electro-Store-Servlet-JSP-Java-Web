<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Danh Sách Người Dùng</title>
</head>
<body>
    <h1>Danh sách người dùng</h1>
    
    <!-- Start the table -->
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Telephone</th>
                <th>Address</th>
                <th>Role</th>
            </tr>
        </thead>
        <tbody>
            <!-- Loop through the list of users -->
            <c:forEach var="user" items="${users}">
                <tr>
                    <td>${user.userId}</td>
                    <td>${user.fullName}</td>
                    <td>${user.email}</td>
                    <td>${user.telephone}</td>
                    <td>${user.address}</td>
                    <td>${user.role.name}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
