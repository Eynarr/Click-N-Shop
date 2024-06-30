<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Crear Reseña</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Crear Reseña</h1>
    <%
        // Obtenemos la sesión existente si existe
        HttpSession sesion = request.getSession(false);
        
        // Verificamos si la sesión y el id_usuario están presentes
        if (sesion != null) {
            Integer id_usuario = (Integer) session.getAttribute("id_usuario");
            
            // Verificamos si el id_usuario no es nulo
            if (id_usuario != null) {
                Connection connection = null;
                PreparedStatement statement = null;
                ResultSet resultSet = null;
                
                try {
                    // Establecemos la conexión con la base de datos
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "Eynar", "123");

                    // Preparamos la consulta SQL para obtener los productos comprados por el usuario
                    String sql = "SELECT p.id_producto, p.nombre_producto FROM Producto p JOIN OrdenItem oi ON p.id_producto = oi.id_producto JOIN Orden o ON oi.id_orden = o.id_orden WHERE o.id_usuario = ?";
                    statement = connection.prepareStatement(sql);
                    statement.setInt(1, id_usuario);

                    // Ejecutamos la consulta y obtenemos los resultados
                    resultSet = statement.executeQuery();

                    // Mostramos los productos comprados por el usuario si hay resultados
                    if (resultSet.next()) {
    %>
                        <form action="guardar_resenha.jsp" method="post">
                            <label for="id_producto">Producto:</label>
                            <select id="id_producto" name="id_producto" required>
                                <%
                                    do {
                                        int idProducto = resultSet.getInt("id_producto");
                                        String nombreProducto = resultSet.getString("nombre_producto");
                                        out.println("<option value=\"" + idProducto + "\">" + nombreProducto + "</option>");
                                    } while (resultSet.next());
                                %>
                            </select><br>
                            
                            <label for="calificacion">Calificación:</label>
						    <select id="calificacion" name="calificacion" required>
						        <option value="">Seleccione una calificación</option>
						        <option value="5">⭐⭐⭐⭐⭐</option>
						        <option value="4">⭐⭐⭐⭐</option>
						        <option value="3">⭐⭐⭐</option>
						        <option value="2">⭐⭐</option>
						        <option value="1">⭐</option>
						    </select><br>
                            
                            <label for="descripcion">Descripción:</label>
                            <textarea id="descripcion" name="descripcion" rows="4" required autocomplete="off" style="resize: none;"></textarea><br>
                            
                            <input type="submit" value="Crear Reseña">
                        </form>
    <%
                    } else {
                        out.println("<h2>No se encontraron productos comprados.</h2>");
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
