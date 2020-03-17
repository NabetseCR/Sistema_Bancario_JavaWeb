<%@page import="Bank.logic.Usuario"%>
<% Usuario usuario = (Usuario) session.getAttribute("usuario");  %>

<header>

    <nav class="navbar navbar-inverser navbar-static-top" role="navigation">
        <div class="container">
            <!--Inicia Menu-->
            <div class="collapse navbar-collapse" id="navegacion-ej">
                <ul class="nav navbar-nav" >
                    <li class="active "><a href="/Proyecto_Banco/presentation/Index.jsp" class="colosh">Inicio</a></li>
                    <li><a href="#" class="colosh">Perfil</a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle colosh" data-toggle="dropdown" role="button">
                            Cuenta <span class="caret"> </span>
                        </a>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="#" class="colosh">Tranferir</a></li>
                            <li class="divider"></li>
                            <li><a href="#" class="colosh">Cuentas</a></li>
                        </ul>
                    </li>
                    <li> <% if (usuario != null) {%>
                    <li>
                        <a href="/Proyecto_Banco/presentation/cliente/cuentas/show">Cuentas</a>
                        <ul>  <!--submenu --> </ul>
                    </li>                        
                    <li >
                        <a  href="#">User: <%=usuario.getCedula()%></a>
                        <ul>  <!--submenu --> </ul>
                    </li> 
                    <li >
                        <a  href="/Proyecto_Banco/presentation/login/logout">Logout</a>
                        <ul>  <!--submenu --> </ul>
                    </li>                
                    <% } %>
                    <% if (usuario == null) {%>
                    <li>
                        <a href="/Proyecto_Banco/presentation/login/show">Login</a>
                    </li>                
                    <% }%>             
                    </li>
                </ul>

            </div>
        </div>
    </nav>  
</header>          

