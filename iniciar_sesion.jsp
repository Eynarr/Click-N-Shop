<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>

    <% 
        // Captura los valores ingresador en el html 
        String email = request.getParameter("usuario");
        String contrasenha = request.getParameter("contrasenha");
        int id_usuario = -1;
        String nombre ="";
        String apellido ="";
        String msg ="";
        // Validaar si el email y contraseña ingresado no son nulos ni tienen un espacio al final
        if ((email != null && !email.trim().isEmpty()) && (contrasenha != null && !contrasenha.trim().isEmpty())) {
            Connection connection = null;
            PreparedStatement statement = null;
            ResultSet resultSet = null;
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "Eynar", "123");
				
                // Consulta donde retorne id usuario, nombre y apellido de la persona que hizo log in
                String sql = "SELECT id_usuario, nombre_usuario, apellido_usuario FROM UsuarioComprador WHERE email_usuario = ? AND contrasenha_usuario = ?";
                statement = connection.prepareStatement(sql);
                statement.setString(1, email);
                statement.setString(2, contrasenha);

                resultSet = statement.executeQuery();

                if (resultSet.next()) {
                	// Guardar en variables locales, los valores de id usuario, nombre y apellido
                    id_usuario = resultSet.getInt("id_usuario");
                    nombre = resultSet.getString("nombre_usuario");
                    apellido = resultSet.getString("apellido_usuario");
                    request.getSession().setAttribute("id_usuario", id_usuario);
                    request.getSession().setAttribute("nombre_usuario", nombre);
                    request.getSession().setAttribute("apellido_usuario", apellido);
                 	// Redirigir a la pagina home
                    response.sendRedirect("Home.html");
                 	// Para que no ejecute las resto de codigo
                    return;
                } else {
                	// En caso de que el usuario sea incorrecto te manda al log in devuelta
                	response.sendRedirect("IniciarSesion.html");
                	return;
                }

            } catch (ClassNotFoundException e) {
                msg = "<h1 style='color: red;'>Error cargando el driver de la base de datos.</h1>";
                e.printStackTrace();
            } catch (SQLException e) {
                msg = "<h1 style='color: red;'>Error de SQL: " + e.getMessage() + "</h1>";
                e.printStackTrace();
            } finally {
                // Cerramos los recursos (ResultSet, Statement, Connection)
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();

            }
        }
    %>
    <%= msg %>

