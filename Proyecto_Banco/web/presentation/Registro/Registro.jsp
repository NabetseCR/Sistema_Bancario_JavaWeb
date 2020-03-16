<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style>div.a {text-align: center;}</style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@ include file="/presentation/Head.jsp" %>
        <title>Registro</title>
    </head>

    <body>
        <%@ include file="/presentation/Header.jsp" %>

        <div class="a"><font id="fontelem" color=black face="arial,verdana" size="4"><b>Registro</b></font>&nbsp;</div>

        <form name="form" action="" method="post">
            <table BORDER style="margin: 0 auto">
                <tr>
                    <td colspan="2" bgcolor="Black"><font id="fontelem" color=white face="arial,verdana" size="3">Información Personal</font></td>
                </tr>
                <tr>
                    <td colspan="2"><label>Identificación: </label><input type="text" name="id" /></td>
                </tr>
                <tr>
                    <td colspan="2" <label>Nombre: </label><input type="text" name="nombre" /></td>
                </tr>
                <tr>
                    <td> <label>Primer Apellido: </label> <input type="text" name="apellido1" /></td>
                    <td><label>Segundo Apellido: </label> <input type="text" name="apellido2" /></td>
                </tr>
                <tr>
                    <td colspan="2"> <label>Edad: </label><input type="text" name="edad" /></td>
                </tr>
                <tr>
                    <td colspan="2"><label>Estado Civil: </label><input type="text" name="estadoCivil" /></td>
                </tr>
                <tr>
                    <td> <label>Provincia: </label><input type="text" name="provicia" /></td>
                    <td> <label>Contón: </label><input type="text" name="canton" /></td>
                </tr>
                <tr>
                    <td colspan="2"><label>Dirección: </label><input type="text" name="direccion" /></td>
                </tr>
                <tr>
                    <td> <label>Teléfono: </label><input type="text" name="telefono" /></td>
                    <td><label>Celular: </label><input type="text" name="celular" /></td>
                </tr>
                <tr>
                    <td colspan="2" bgcolor="Black"><font id="fontelem" color=white face="arial,verdana" size="3">Información de Cuenta</font></td>
                </tr>
                <tr>
                    <td colspan="2"> <label>Correo Electronico: </label><input type="text" name="email" /></td>
                </tr>
                <tr>
                    <td colspan="2"><label>Contraseña: </label><input type="password" name="password" /></td>
                </tr>
                <tr>
                    <td colspan="2"> <input type="submit" value="Finalizar" /></td>
                </tr>
            </table>
        </form> 
    </body>

</html>