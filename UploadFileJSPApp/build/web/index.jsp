<%-- 
    Document   : index
    Created on : Dec 4, 2017, 6:05:04 PM
    Author     : jean
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<script>

$(function() {
    $(window).on('resize', function resize()  {
        $(window).off('resize', resize);
        setTimeout(function () {
            var content = $('#content');
            var top = (window.innerHeight - content.height()) / 2;
            content.css('top', Math.max(0, top) + 'px');
            $(window).on('resize', resize);
        }, 50);
    }).resize();
});

</script>

<html>

    <head>

        <style type="text/css">

            body {background-color: khaki;} 
            
            #content {
    max-width: 1000px;
    margin: auto;
    left: 1%;
    right: 1%;
    position: absolute;
}
.center{
 position:absolute;
    height: X px;
    width: Y px;
    left:50%;
    top:50%;
    margin-top:- X/2 px;
    margin-left:- Y/2 px;
}
        </style>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>File Upload App in JSP</title>

    </head>

    <body>
    <center>
        <div  id="content" class="center">
        
         <form action="process.jsp" method="post" enctype="multipart/form-data">


        </form>
        
          <form action="process.jsp" method="post" enctype="multipart/form-data">


        </form>

        <form action="process.jsp" method="post" enctype="multipart/form-data">

            <b>Select File:</b> <input type="file" name="fname"><br/>

            <input type="submit" value="Upload">

        </form>
        
         <form>
<input type="button" value="Extract Terms" onclick="window.location.href='http://localhost:8084//FCH2'" />
</form>

 
         <form> 
<input type="button" value="Identify Hypernym" onclick="window.location.href='http://localhost:8084//WCL'" />
</form>

       
        </div>
        </center>
        
    </body>

</html> 