<%@page language="java" import="java.util.*" contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="oms.order.Order"%>
<%@page import="oms.movie.Movie"%>
<%@page import="oms.movie.Movies"%>
<%@page import="oms.order.Orders"%>

<!DOCTYPE html>
<html>
    <head class = "header">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order cancelled</title>
        <link rel="stylesheet" type="text/css" href="blockbuster.css">
    <img src="blockbusterlogo.png" alt="Blockbuster Logo" class="logo">
</head>

<body class = "body">
    <%-- JavaBean --%>
    <% String filePath = application.getRealPath("WEB-INF/history.xml");%>
    <jsp:useBean id="orderApp" class="oms.order.OrderApplication" scope="application">
        <jsp:setProperty name="orderApp" property="filePath" value="<%=filePath%>"/>
    </jsp:useBean>
    <%-- JavaBean --%>
    <% String filePath2 = application.getRealPath("WEB-INF/movies.xml");%>
    <jsp:useBean id="movieApp" class="oms.movie.MovieApplication" scope="application">
        <jsp:setProperty name="movieApp" property="filePath" value="<%=filePath2%>"/>
    </jsp:useBean>

    <%-- Sets order status to "cancelled" and restocks affected movies. --%>
    <%
        Orders orders = orderApp.getOrders();
        int orderid = Integer.parseInt(request.getParameter("orderid"));
        Order order = orders.checkId(orderid);
        // If the order's status is submitted
        if (order.getStatus() == "Submitted") {
            // set the status to cancelled,
            orders.removeOrder(order);
            order.setStatus("Cancelled");
            orders.addOrder(order);
            // save changes to orders, update in XML,
            orderApp.setOrders(orders);

            // and restock the affected movies.
            ArrayList<Movie> affected_movies = order.getMovies();
            Movies all_movies = movieApp.getMovies();
            for (Movie movie : affected_movies) {
                Movie matched_movie = all_movies.getTitleMatches(movie.getTitle()).get(0);
                int currentcopies = matched_movie.getAvailablecopies();
                all_movies.removeMovie(matched_movie);
                matched_movie.setAvailablecopies(currentcopies + movie.getPurchased());
                all_movies.addMovie(matched_movie);
            }
            // Save changes to movies and update in XML. 
            movieApp.setMovies(all_movies);
        }
        response.sendRedirect("accountmain.jsp");
    %>
</body>
</html>