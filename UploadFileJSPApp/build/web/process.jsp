<%-- 
    Document   : process
    Created on : Dec 4, 2017, 6:05:55 PM
    Author     : jean
--%>
<%@page import="com.oreilly.servlet.MultipartRequest" %>

<%

    MultipartRequest m=new MultipartRequest(request, "C:/Program Files/Apache Software Foundation/Apache Tomcat 8.0.27/bin/training");

    out.println("Successfully Uploaded..");

    %> 