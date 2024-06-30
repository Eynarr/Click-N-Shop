<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Guardar Reseña</title>
</head>
<body>
    <%
        // Obtenemos la sesión existente si existe
        HttpSession ses = request.getSession(false);
        
        // Verificamos si la sesión y el id_usuario están presentes
        if (ses != null) {
            Integer id_usuario = (Integer) session.getAttribute("id_usuario");
            
            // Verificamos si el id_usuario no es nulo
            if (id_usuario != null) {
                // Obtenemos los datos del formulario
                String idProductoStr = request.getParameter("id_producto");
                String calificacion = request.getParameter("calificacion");
                String descripcion = request.getParameter("descripcion");
                
                // Convertimos idProductoStr a número
                int id_producto = Integer.parseInt(idProductoStr);

                Connection connection = null;
                PreparedStatement statement = null;
                
                try {
                    // Establecemos la conexión con la base de datos
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "Eynar", "123");

                    // Preparamos la inserción SQL para guardar la reseña
                    String sql = "INSERT INTO resenhas (id_resenha, id_usuario, calificacion, descripcion, id_producto) VALUES (seq_resenha.nextval, ?, ?, ?, ?)";
                    statement = connection.prepareStatement(sql);
                    statement.setInt(1, id_usuario);
                    statement.setString(2, calificacion);
                    statement.setString(3, descripcion);
                    statement.setInt(4, id_producto);

                    // Ejecutamos la inserción
                    int rowsInserted = statement.executeUpdate();

                    if (rowsInserted > 0) {
                        out.println("<h2>Reseña creada exitosamente.</h2>");
                    } else {
                        out.println("<h2>Error al crear la reseña.</h2>");
                    }
                } catch (ClassNotFoundException e) {
                    out.println("<h1 style='color: red;'>Error en el driver de la base de datos.</h1>");
                    e.printStackTrace();
                } catch (SQLException e) {
                    out.println("<h1 style='color: red;'>Error de SQL: " + e.getMessage() + "</h1>");
                    e.printStackTrace();
                } finally {
                    // Cerramos los recursos (Statement, Connection)
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
