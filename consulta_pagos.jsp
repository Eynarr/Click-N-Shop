<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Pagos de Órdenes</title>
    <link rel="stylesheet" href="styleIS.css">
        <style>
        /* Estilos para la tabla */
        table {
            border-collapse: collapse;
            width: 75%;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }


    
    </style>
</head>

<header>
    <div class="header">
        <a href="Home.html" class="logo"><img src="img/Logo-removebg.png" alt="Logo"></a>
        <div class="header-derecha">
            <a href="https://www.google.com/" target="_blank"> 
                <svg width="30px" height="30px" viewBox="0 0 80 80" fill="none" xmlns="http://www.w3.org/2000/svg"><!--Vector lupa para el ícono de búsqeda-->
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M29.0688 15.5967C22.494 17.3584 17.3584 22.494 15.5967 29.0688C13.8349 35.6437 15.7147 42.6591 20.5278 47.4722C25.341 52.2854 32.3563 54.1651 38.9312 52.4034C41.5388 51.7047 43.9195 50.4748 45.9537 48.8354L48.1906 51.0723C47.4887 52.8654 47.862 54.9821 49.3105 56.4309L62.039 69.1628C63.9909 71.1152 67.1561 71.1155 69.1082 69.1633C71.0601 67.2115 71.0603 64.047 69.1087 62.0949L56.3802 49.3631C54.9309 47.9133 52.8126 47.5399 51.0186 48.243L48.7884 46.0128C50.4516 43.9658 51.6979 41.5639 52.4034 38.9312C54.1651 32.3563 52.2854 25.341 47.4722 20.5278C42.6591 15.7147 35.6437 13.8349 29.0688 15.5967ZM33.9963 20.7417C31.7086 20.742 29.4201 21.334 27.3699 22.5177C23.2686 24.8856 20.742 29.2615 20.7417 33.9973C20.7417 35.1018 21.637 35.9973 22.7416 35.9974C23.8462 35.9974 24.7417 35.1021 24.7417 33.9975C24.7419 30.6907 26.5061 27.6352 29.3699 25.9818C30.8015 25.1552 32.3987 24.7419 33.9968 24.7417C35.1014 24.7416 35.9967 23.846 35.9966 22.7414C35.9964 21.6369 35.1009 20.7416 33.9963 20.7417Z" fill="#C2CCDE" />
                  </svg>
                  
              </a>
          <a href="Home.html">Home</a>
          <a href="IniciarSesion.html">Iniciar Sesión</a>
          <a href="registroUsuario.html">Registrarse</a>
          <a href="consulta_ordenes.jsp">Órdenes</a>
          <a href="consulta_pagos.jsp">Pagos</a>
          <a href="ConsultaProductos.html">Productos</a>
          <a href="ConsultaInventario.html">Inventario</a>
          <a href="guardar_resenha.jsp">Crear Reseña</a>
          <a href="consulta_resenhas.jsp">Reseñas</a>
          <a href="Sobre Nosotros.html">Sobre Nosotros</a>
          <a href="">
            <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
                <path fill-rule="evenodd" d="M4 4a1 1 0 0 1 1-1h1.5a1 1 0 0 1 .979.796L7.939 6H19a1 1 0 0 1 .979 1.204l-1.25 6a1 1 0 0 1-.979.796H9.605l.208 1H17a3 3 0 1 1-2.83 2h-2.34a3 3 0 1 1-4.009-1.76L5.686 5H5a1 1 0 0 1-1-1Z" clip-rule="evenodd"/>
              </svg>
            </a>
        <a href="https://www.facebook.com/" target="_blank"><img src="https://img.icons8.com/?size=100&id=118490&format=png&color=ffffff" alt="Facebook"></a>
        <a href="https://www.tiktok.com/foryou?lang=en" target="_blank"><img src="https://img.icons8.com/?size=100&id=juS4pYkbvSCh&format=png&color=ffffff" alt="TikTok"></a>
        <a href="https://www.youtube.com/" target="_blank"><img src="https://img.icons8.com/?size=100&id=85433&format=png&color=ffffff" alt="YouTube"></a>
          

          
          
        </div>
      </div> 
</header>

<body>

	<section>
    <h1>Pagos del Usuario</h1>
    <%
        // Obtenemos la sesión existente si existe
        HttpSession sesion = request.getSession(false);
        
        // Verificamos si la sesión y el id_usuario están presentes
        if (session != null) {
            Integer id_usuario = (Integer) session.getAttribute("id_usuario");
            String nombre = (String) session.getAttribute("nombre_usuario");
            String apellido = (String) session.getAttribute("apellido_usuario");
            
            // Verificamos si el id_usuario no es nulo
            if (id_usuario != null) {
                Connection connection = null;
                PreparedStatement statement = null;
                ResultSet resultSet = null;
                
                try {
                    // Establecemos la conexión con la base de datos
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "Eynar", "123");

                    // Preparamos la consulta SQL para obtener las órdenes del usuario
                    String sql = "SELECT id_pago, fecha_pago, modo_pago, id_orden FROM Pago WHERE id_usuario = ?";
                    statement = connection.prepareStatement(sql);
                    statement.setInt(1, id_usuario);

                    // Ejecutamos la consulta y obtenemos los resultados
                    resultSet = statement.executeQuery();

                    // Mostramos las ordenes del usuario si hay resultados
                    if (resultSet.next()) {
                        out.println("<h2>Pagos del usuario " + nombre + "  " + apellido + ":</h2>");
                        out.println("<table border='1'>");
                        out.println("<tr><th>ID Pago</th><th>Fecha de Pago</th><th>Metodo de Pago</th><th>ID Carrito</th></tr>");
                        
                        do {
                            int idPago = resultSet.getInt("id_pago");
                            String fechaPago = resultSet.getString("fecha_pago");
                            String modoPago = resultSet.getString("modo_pago");
                            int idOrden = resultSet.getInt("id_orden");

                            out.println("<tr>");
                            out.println("<td>" + idPago + "</td>");
                            out.println("<td>" + fechaPago + "</td>");
                            out.println("<td>" + modoPago + "</td>");
                            out.println("<td>" + idOrden + "</td>");
                            out.println("</tr>");
                        } while (resultSet.next());

                        out.println("</table>");
                    } else {
                        out.println("<h2>No se encontraron pagos para " + nombre + "  " + apellido + ".</h2>");
                    }
                } catch (ClassNotFoundException e) {
                    out.println("<h1 style='color: red;'>Error en el driver de la base de datos.</h1>");
                    e.printStackTrace();
                } catch (SQLException e) {
                    out.println("<h1 style='color: red;'>Error de SQL: " + e.getMessage() + "</h1>");
                    e.printStackTrace();
                } finally {
                    // Cerramos los recursos (ResultSet, Statement, Connection)
                    try {
                        if (resultSet != null) resultSet.close();
                        if (statement != null) statement.close();
                        if (connection != null) connection.close();
                    } catch (SQLException e) {
                        out.println("<h1 style='color: red;'>Error al cerrar conexiones: " + e.getMessage() + "</h1>");
                        e.printStackTrace();
                    }
                }
            } else {
                out.println("<h2>No se ha iniciado sesión.</h2>");
            }
        } else {
            out.println("<h2>No se ha iniciado sesión.</h2>");
        }
    %>
    </section>
</body>

<footer>
    <div class="divf">
    <nav>
        <ul>
            <li><a href="registroUsuario.html">Únete</a></li>
			<li><a href="cerrar_sesion.jsp">Cerrar Sesión</a></li>
            <li><a href="">Vender</a></li>
            <li><a href="">Ayuda</a></li>
        </ul>
    </nav>

    <nav>

        <ul>
            <li><a href="">Términos y Condiciones</a></li>
            <li><a href="">Políticas de Privacidad</a></li>
            <li><a href="Sobre Nosotros.html">Sobre Nosotros</a></li>
        </ul>
    </nav>

    <nav>
       
        <img src="https://img.icons8.com/?size=100&id=118490&format=png&color=000000" alt="Facebook">
        <img src="https://img.icons8.com/?size=100&id=juS4pYkbvSCh&format=png&color=000000" alt="TikTok">
        <img src="https://img.icons8.com/?size=100&id=85140&format=png&color=000000" alt="Instagram">
        <img src="https://img.icons8.com/?size=100&id=85433&format=png&color=000000" alt="YouTube">
        
    </nav>  
    </div>
    <p>Copyright 2024</p>

</footer>

</html>
