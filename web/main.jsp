<%@page import="oms.user.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head class = "header">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Main</title>
        <link rel="stylesheet" type="text/css" href="blockbuster.css">
        <img src="blockbusterlogo.png" alt="Blockbuster Logo" class="logo">
        
    </head>
    
    <body class = "body">
        <%
            User user = (User) session.getAttribute("user");
            if (request.getParameter("email") == null) {
               response.sendRedirect("login.jsp");
            }
        %>
        <p>Click <a href="account.jsp">here</a> to update your account information.</p>
        <p>Click <a href="index.jsp">here</a> to view our movie inventory.</p>
    </body>
</html>
