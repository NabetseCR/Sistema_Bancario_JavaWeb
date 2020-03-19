<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="Bank.model.ModelLogin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <%@ include file="/presentation/Head.jsp" %>
    </head>
    <body >

        <%@ include file="/presentation/Header.jsp" %>

        <% ModelLogin model = (ModelLogin) request.getAttribute("model"); %>
        <% Map<String, String> errores = (Map<String, String>) request.getAttribute("errores"); %>
        <% Map<String, String[]> form = (errores == null) ? this.getForm(model) : request.getParameterMap();%>

        <div style="width:50%; margin:auto;">
            <form name="form" action="/Proyecto_Banco/presentation/login/login" method="post" > 
                <table  class="table letras">
                    <tr>
                        <td colspan="2" bgcolor="black"><font id="fontelem" color=white face="arial,verdana" size="3">Login</td>
                    </tr>
                    <tr>
                        <td>Cedula</td>
                        <td><input class="<%=erroneo("cedulaFld", errores)%>" placeholder="Cedula del usuario" type="text" name="cedulaFld" value="<%=form.get("cedulaFld")[0]%>" title="<%=title("cedulaFld", errores)%>"></td>
                    </tr>
                    <tr>
                        <td>Clave</td>
                        <td><input class="<%=erroneo("claveFld", errores)%>" placeholder="Clave del usuario" type="password" name="claveFld" value="<%=form.get("claveFld")[0]%>" title="<%=title("claveFld", errores)%>"></td>
                    </tr>
                    <tr>
                        <td colspan="2" ><button  style="margin-bottom: 15px">Ingresar</button> </td>
                    </tr>
                </table>
                <!--<div class="panel" style="width:30%;">
                       <div class="fila encabezado">Login</div>
                       <div class="fila">
                           <div class="etiqueta">Cedula</div>
                           <div class="campo"><input class="<%=erroneo("cedulaFld", errores)%>" placeholder="Cedula del usuario" type="text" name="cedulaFld" value="<%=form.get("cedulaFld")[0]%>" title="<%=title("cedulaFld", errores)%>"></div>
                       </div>
                       <div class="fila">
                           <div class="etiqueta">Clave</div>
                           <div class="campo"><input class="<%=erroneo("claveFld", errores)%>" placeholder="Clave del usuario" type="password" name="claveFld" value="<%=form.get("claveFld")[0]%>" title="<%=title("claveFld", errores)%>"></div>
                       </div>
                       <div class="fila encabezado"><button  style="margin-bottom: 15px">Ingresar</button> </div>
                   </div> -->
            </form>
        </div>
        <%@ include file="/presentation/Footer.jsp" %>                  
    </body>
</html>
<%!
    private String erroneo(String campo, Map<String, String> errores) {
        if ((errores != null) && (errores.get(campo) != null)) {
            return "is-invalid";
        } else {
            return "";
        }
    }

    private String title(String campo, Map<String, String> errores) {
        if ((errores != null) && (errores.get(campo) != null)) {
            return errores.get(campo);
        } else {
            return "";
        }
    }

    private Map<String, String[]> getForm(ModelLogin model) {
        Map<String, String[]> values = new HashMap<>();
        values.put("cedulaFld", new String[]{model.getCurrent().getCedula()});
        values.put("claveFld", new String[]{model.getCurrent().getClave()});
        return values;
    }

%> 