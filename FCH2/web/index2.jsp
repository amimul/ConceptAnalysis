<%-- 
    Document   : index2
    Created on : Dec 2, 2017, 9:00:50 PM
    Author     : jean
--%>
<%@page import="it.uniroma1.lcl.wcl.classifiers.lattice.WCLClassifier"%>
<%@page import="it.uniroma1.lcl.wcl.classifiers.lattice.TripleLatticeClassifier"%>
<%@page import="it.uniroma1.lcl.wcl.data.dataset.AnnotatedDataset"%>
<%@page import="it.uniroma1.lcl.wcl.data.dataset.Dataset"%>
<%@page import="it.uniroma1.lcl.jlt.util.Language"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>



<%
    Language targetLanguage = Language.EN;
 String currentDirectory = new File("").getAbsolutePath();

    String trainingDatasetFile ="data/training/wiki_good.EN.html";
  Dataset ts;

 ts = new AnnotatedDataset(trainingDatasetFile, targetLanguage);
  
WCLClassifier c = new TripleLatticeClassifier(targetLanguage);
c.train(ts);

 
  %>
    
    
    
    
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
