<%@page import="Bank.model.ModelCuenta"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Bank.logic.Cuenta"%>
<%
    ModelCuenta model = (ModelCuenta) request.getAttribute("model");
    Cuenta cuenta = model.getCurrent();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@ include file="/presentation/Head.jsp" %>
        <title>Cuenta</title> 
    </head>
    <body >
        <%@ include file="/presentation/Header.jsp" %>
        <div>
            <table class="table" style="border:1px solid black;margin-left:auto;margin-right:auto; width: 50%">
                <thead>
                <td colspan="2"><h1 class="colosh2">Cuenta</h1></td>   
                </thead>
                <tbody>
                    <tr><td>Numero</td> <td>Saldo</td></tr>

                    <tr><td><%=cuenta.getNumero()%></td> <td><%=cuenta.getSaldo()%></td></tr>
                </tbody>
            </table> 
        </div>     
        <%@ include file="/presentation/Footer.jsp" %>
    </body>
</html>








