<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*" %>

<%
    // Invalidar la sesión actual
    request.getSession().invalidate();
    // Redirigir a home
    response.sendRedirect("Home.html");
%>
