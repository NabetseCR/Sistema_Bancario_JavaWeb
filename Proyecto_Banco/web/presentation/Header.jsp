<%@page import="Bank.logic.Usuario"%>
<% Usuario usuario=  (Usuario) session.getAttribute("usuario");  %>

<header>
    <div class="logo">
        <span>Banco Santander</span>
        <img src="/Proyecto_Banco/images/logo.png">
    </div> 
    <div class="menu">
        <ul> 
              <li>
                <a href="/Proyecto_Banco/presentation/Index.jsp">Inicio</a>
              </li>
                        <% if (usuario!=null){ %>
                <li>
                  <a href="/Proyecto_Banco/presentation/cliente/cuentas/show">Cuentas</a>
                  <ul>  <!--submenu --> </ul>
                </li>                        
                <li >
                  <a  href="/Proyecto_Banco/presentation/cliente/datos/show">User:<%=usuario.getCedula()%></a>
                  <ul>  <!--submenu --> </ul>
                </li> 
                <li >
                  <a  href="/Proyecto_Banco/presentation/login/logout">Logout</a>
                  <ul>  <!--submenu --> </ul>
                </li>                
                        <% } %>
                        <% if (usuario==null){%>
                <li>
                  <a href="/Proyecto_Banco/presentation/login/show">Login</a>
                </li>
                
                        <% }%>             
            </ul>
    </div>
  </header>          

