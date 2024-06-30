<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Resultado de la Consulta Por Inventario</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Resultado de la Consulta</h1>
    <%
        String inventarioStr = request.getParameter("inventario");
        if (inventarioStr != null && !inventarioStr.trim().isEmpty()) {
            int inventario = Integer.parseInt(inventarioStr);
            Connection connection = null;
            PreparedStatement statement = null;
            ResultSet resultSet = null;

            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "Eynar", "123");

                String sql = "SELECT id_producto, nombre_producto, descripcion_producto, precio FROM Producto WHERE inventario >= ?";
                statement = connection.prepareStatement(sql);
                statement.setInt(1, inventario);

                resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    out.println("<h2>Productos con inventario mayor o igual a " + inventario + ":</h2>");
                    out.println("<table border='1'>");
                    out.println("<tr><th>ID del Producto</th><th>Nombre del Producto</th><th>Descripción del Producto</th><th>Precio</th></tr>");
                    do {
                        int idProducto = resultSet.getInt("id_producto");
                        String nombreProducto = resultSet.getString("nombre_producto");
                        String descripcionProducto = resultSet.getString("descripcion_producto");
                        double precio = resultSet.getDouble("precio");

                        out.println("<tr>");
                        out.println("<td>" + idProducto + "</td>");
                        out.println("<td>" + nombreProducto + "</td>");
                        out.println("<td>" + descripcionProducto + "</td>");
                        out.println("<td>" + precio + "</td>");
                        out.println("</tr>");
                    } while (resultSet.next());
                    out.println("</table>");
                } else {
                    out.println("<h2>No se encontraron productos con inventario mayor o igual a " + inventario + ".</h2>");
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
