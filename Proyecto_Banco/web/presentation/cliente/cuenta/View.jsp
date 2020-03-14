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

    <div class="panel" style="width:50%;">
        <div class="fila encabezado">Cuenta</div>
        <div class="fila">
               <div class="etiqueta">Numermo</div>
              <div class="campo"><%=cuenta.getNumero()%></div>
        </div>
        <div class="fila">
          <div class="etiqueta">Saldo</div>
          <div class="campo"><%=cuenta.getSaldo()%></div>
        </div>
    </div>     
     <%@ include file="/presentation/Footer.jsp" %>
</body>
</html>








