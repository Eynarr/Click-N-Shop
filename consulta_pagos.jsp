<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Pagos de Órdenes</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
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
                        out.println("<h2>No se encontraron pagos para " + nombre + "  " + apellido + ":</h2>");
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
</body>
</html>
