<%@page import="Bank.logic.Usuario"%>
<% Usuario usuario = (Usuario) session.getAttribute("usuario");  %>

<header>

    <nav class="navbar navbar-inverser navbar-static-top" role="navigation">
        <div class="container">
            <!--Inicia Menu-->
            <div class="collapse navbar-collapse" id="navegacion-ej">
                <ul class="nav navbar-nav" >
                    <li class="active "><a href="/Proyecto_Banco/presentation/Index.jsp" class="colosh">Inicio</a></li>


                    <li> <% if (usuario != null) {%>
                    <li>
                        <a href="/Proyecto_Banco/presentation/cliente/cuentas/show" class="colosh">Cuentas</a>
                        <ul>  <!--submenu --> </ul>
                    </li>                        
                    <li >
                        <a  href="#" class="colosh">User: <%=usuario.getCedula()%></a>
                        <ul>  <!--submenu --> </ul>
                    </li> 
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle colosh" data-toggle="dropdown" role="button">
                            Cuenta <span class="caret"> </span>
                        </a>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="#" class="colosh">Perfil</a></li>
                            <li class="divider"></li>
                            <li><a href="#" class="colosh">Tranferir</a></li>
                            <li class="divider"></li>
                            <li><a href="#" class="colosh">Cuentas</a></li>
                        </ul>
                    </li>
                    <li >
                        <a  href="/Proyecto_Banco/presentation/login/logout" class="colosh">Logout</a>
                        <ul>  <!--submenu --> </ul>
                    </li>                
                    <% } %>
                    <% if (usuario == null) {%>
                    <li>
                        <a href="/Proyecto_Banco/presentation/login/show" class="colosh">Login</a>

                    </li>   
                    <li><a href="/Proyecto_Banco/presentation/Registro/show" class="colosh">Registro</a></li>
                        <% }%>             
                    </li>
                </ul>
                <li>
                    <a href="#" class="navbar-form navbar-right">
                        <img src="/Proyecto_Banco/img/icbc-logo.jpg" alt="" height="40"width="40">
                    </a>
                </li>


            </div>
        </div>
    </nav>  
</header>          

