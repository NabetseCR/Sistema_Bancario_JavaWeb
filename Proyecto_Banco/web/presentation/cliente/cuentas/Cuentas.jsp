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

        <div>


            <table class="table" style="border:1px solid black;margin-left:auto;margin-right:auto; width: 50%">
                <thead>
                <td colspan="2"><h1 class="colosh2">Listado de Cuentas del Cliente</h1></td>   

                </thead>
                <tbody>
                    <tr> <td>Numero</td> <td>Saldo</td>  </tr>
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








