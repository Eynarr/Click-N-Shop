<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reseñas del Usuario</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Reseñas del Usuario</h1>
    <%
        // Obtenemos la sesión existente si existe
        HttpSession s = request.getSession(false);
        
        // Verificamos si la sesión y el id_usuario están presentes
        if (s != null) {
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

                    // Preparamos la consulta SQL para obtener las reseñas del usuario
                    String sql = "SELECT * FROM resenhas WHERE id_usuario = ?";
                    statement = connection.prepareStatement(sql);
                    statement.setInt(1, id_usuario);

                    // Ejecutamos la consulta y obtenemos los resultados
                    resultSet = statement.executeQuery();

                    // Mostramos las reseñas del usuario si hay resultados
                    if (resultSet.next()) {
                        out.println("<h2>Reseñas del usuario " + nombre + " " + apellido + ":</h2>");
                        out.println("<table border='1'>");
                        out.println("<tr><th>ID Reseña</th><th>Calificación</th><th>Descripción</th><th>ID Producto</th></tr>");
                        
                        do {
                            int idResenha = resultSet.getInt("id_resenha");
                            String calificacion = resultSet.getString("calificacion");
                            String descripcion = resultSet.getString("descripcion");
                            int idProducto = resultSet.getInt("id_producto");

                            out.println("<tr>");
                            out.println("<td>" + idResenha + "</td>");
                            out.println("<td>" + calificacion + "</td>");
                            out.println("<td>" + descripcion + "</td>");
                            out.println("<td>" + idProducto + "</td>");
                            out.println("</tr>");
                        } while (resultSet.next());

                        out.println("</table>");
                    } else {
                        out.println("<h2>No se encontraron reseñas para " + nombre + " " + apellido + ".</h2>");
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
            } else {
                out.println("<h2>No se ha iniciado sesión.</h2>");
            }
        } else {
            out.println("<h2>No se ha iniciado sesión.</h2>");
        }
    %>
</body>
</html>
