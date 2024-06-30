<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Resultado de la Consulta Por Productos</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Resultado de la Consulta Por ID</h1>
    <%
        String idProductoString = request.getParameter("id_producto");
        if (idProductoString != null && !idProductoString.trim().isEmpty()) {
        	// Convertimos la cadena de texto a un entero
            int idProducto = Integer.parseInt(idProductoString);
            Connection connection = null;
            PreparedStatement statement = null;
            ResultSet resultSet = null;

            try {
                // Establecemos la conexión con la base de datos
                Class.forName("oracle.jdbc.driver.OracleDriver");
                connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "Eynar", "123");

                // Preparamos la consulta SQL para obtener el producto por su ID
                String sql = "SELECT nombre_producto, descripcion_producto FROM Producto WHERE id_producto = ?";
                statement = connection.prepareStatement(sql);
                statement.setInt(1, idProducto);

                // Ejecutamos la consulta y obtenemos los resultados
                resultSet = statement.executeQuery();

                // Mostramos los detalles del producto si hay resultados
                if (resultSet.next()) {
                	out.println("<h2>Producto con ID " + idProducto + ":</h2>");
                    String nombreProducto = resultSet.getString("nombre_producto");
                    String descripcionProducto = resultSet.getString("descripcion_producto");

                    out.println("<h2>Detalles del Producto:</h2>");
                    out.println("<table border='1'>");
                    out.println("<tr><th>Nombre del Producto</th><th>Descripción del Producto</th></tr>");
                    out.println("<tr>");
                    out.println("<td>" + nombreProducto + "</td>");
                    out.println("<td>" + descripcionProducto + "</td>");
                    out.println("</tr>");
                    out.println("</table>");
                } else {
                    out.println("<h2>No se encontró ningún producto con el ID " + idProducto + ".</h2>");
                }
            } catch (ClassNotFoundException e) {
                out.println("<h1 style='color: red;'>Error en el driver de la base de datos.</h1>");
                e.printStackTrace();
            } catch (SQLException e) {
                out.println("<h1 style='color: red;'>Error de SQL: " + e.getMessage() + "</h1>");
                e.printStackTrace();
            } finally {
                // Cerramos los recursos (ResultSet, Statement, Connection)
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            }
        }
    %>
</body>
</html>
