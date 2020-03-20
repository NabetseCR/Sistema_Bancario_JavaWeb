<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="Bank.model.ModelDatos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@ include file="/presentation/Head.jsp" %>
        <title>Datos Personales</title>
    </head>
    <body >

        <%@ include file="/presentation/Header.jsp" %>

        <% ModelDatos model = (ModelDatos) request.getAttribute("model"); %>
        <% Map<String, String> errores = (Map<String, String>) request.getAttribute("errores"); %>
        <% Map<String, String[]> form = (errores == null) ? this.getForm(model) : request.getParameterMap();%>
      
        <form name="form" action="/Proyecto_Banco/presentation/cliente/datos/update" method="post" >
            <div>
                <table class="table" style="border:1px solid black;margin-left:auto;margin-right:auto; width: 50%">
                    <thead>
                    <td colspan="2"><h1 class="colosh2">Datos</h1></td>   
                    </thead>
                    <tbody>
                        <tr><td>Cedula</td> <td>Nombre</td></tr>

                        <tr><td><%=model.getCurrent().getCedula()%></td> 
                            <td><input class="<%=erroneo("nombreFld", errores)%>" placeholder="Nombre del usuario" type="text" name="nombreFld" value="<%=form.get("nombreFld")[0]%>" title="<%=title("nombreFld", errores)%>"></td></tr>
                        <tr><td><button  style="margin-bottom: 15px">Actualizar</button></td></tr>
                    </tbody>
                </table> 
            </div>
        </form>
        
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

    private Map<String, String[]> getForm(ModelDatos model) {
        Map<String, String[]> values = new HashMap<>();
        values.put("cedulaFld", new String[]{model.getCurrent().getCedula()});
        values.put("nombreFld", new String[]{model.getCurrent().getNombre()});
        return values;
    }

%> 