<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@ include file="/presentation/Head.jsp" %>
        <title>ICBC</title> 
    </head>
    <body >
        <%@ include file="/presentation/Header.jsp" %>

        <section class="jumbotron">
            <div class="container">
                <h1>ICBC</h1>
                <p>By your side, as your trust</p>

            </div>
            <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                <ol class="carousel-indicators">
                    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                </ol>
                <div class="carousel-inner" style="width:85%; margin:auto;">
                    <div class="item active">
                        <img src="../img/icbc-card.jpg" alt="..." style="width:50%; margin:auto;">
                        <div class="carousel-caption">

                        </div>
                    </div>
                    <div class="item">
                        <img src="../img/icbc-back.jpg" alt="..." style="width:50%; margin:auto;">
                        <div class="carousel-caption">

                        </div>
                    </div>
                    <div class="item">
                        <img src="../img/icbc-office.jpg" alt="..." style="width:50%; margin:auto;">
                        <div class="carousel-caption">

                        </div>
                    </div>
                </div>
                <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left"></span>
                </a>
                <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right"></span>
                </a>
            </div> 
        </section>   

        <%@ include file="/presentation/Footer.jsp" %>


    </body>
</html>