<%@page import="Bank.model.ModelCuentas"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Bank.logic.Cuenta"%>
<%
    ModelCuentas model = (ModelCuentas) request.getAttribute("model");
    List<Cuenta> cuentas = model.getCuentas();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@ include file="/presentation/Head.jsp" %>
        <title>Cuentas</title> 
    </head>
    <body >
        <%@ include file="/presentation/Header.jsp" %>

        <div style="width:50%;margin:auto;">
            <h1>Listado de Cuentas del Cliente</h1>     

            <table>
                <thead>
                    <tr> <td>Numero</td> <td>Saldo</td>  </tr>
                </thead>
                <tbody>
                    <% for (Cuenta c : cuentas) {%>
                    <tr> <td><a href="/Proyecto_Banco/presentation/cliente/cuenta/show?numeroFld=<%=c.getNumero()%>"><%=c.getNumero()%> </td>  
                        <td><%=c.getSaldo()%></td></tr> 
                    <!--                         <tr> <td><form action="/Proyecto_Banco/presentation/cliente/cuenta/show">
                                                        <input type="hidden" name="numeroFld" value="<%=c.getNumero()%>"> 
                                                        <button class="link-button"> <%=c.getNumero()%> </button> </form> </td>  
                                                <td><%=c.getSaldo()%></td></tr>  -->              
                    <%}%>
                </tbody>
            </table>          
        </div> 
        <%@ include file="/presentation/Footer.jsp" %>
    </body>
</html>








