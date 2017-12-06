<%-- 
    Document   : index
    Created on : Dec 2, 2017, 7:44:21 PM
    Author     : jean
--%>



     

<%@page import="java.nio.charset.Charset"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.nio.file.Path"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>


<%@page  import= "fr.univnantes.termsuite.model.Lang"%>
<%@page  import= "fr.univnantes.termsuite.model.TermProperty"%>
<%@page  import ="fr.univnantes.termsuite.utils.TermHistory"%>
<%@page  import= "java.io.IOException"%>
<%@page  import= "java.nio.file.Paths"%>
<%@page import ="java.util.ArrayList"%>
<%@ page import="Terms.Term"%>

<% 
          Term tr= new Term();
          out.write(tr.extraction().toString());
          
          ArrayList <String> terms = tr.extraction();
          Path p = Paths.get("output.txt");

          FileWriter writer = new FileWriter("terms.txt"); 
for(String str: terms) {
  writer.write(str);
writer.write("\n");

}
writer.close();
          
          //Term.main(new String[] {"some", "arguments"});

//   Language targetLanguage = Language.EN;
//
//    
//    String trainingDatasetFile ="data/training/wiki_good.EN.html";
//  Dataset ts;
//
// ts = new AnnotatedDataset(trainingDatasetFile, targetLanguage);
//  
//WCLClassifier c = new TripleLatticeClassifier(targetLanguage);
//c.train(ts);
//
//
//             Sentence sentence = Sentence.createFromString("WCL",
//                                "WCL is a classifier.", 
//                                targetLanguage);
//            // test the sentence 
//            SentenceAnnotation sa = c.test(sentence);
//            // print the hypernym
//            if (sa.isDefinition()) 
//            { 
//                out.println(sa.getHyper());
//                
//            }
//    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
        

        // Do the NLP preprocessings


  
//terminologyService.terms(TermOrdering.natural()).forEach(t -> {
   
  //System.out.format(" %s%n", t.getPilot());
//sortedTerms.add(t.getPilot());
   
    //   });

    
  //out.write(sortedTerms.toString());
    
 
  %>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Term Extraction</title>
    </head>
    <body>
      
    </body>
</html>
