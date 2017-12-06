<%-- 
    Document   : index
    Created on : Dec 3, 2017, 9:58:40 AM
    Author     : jean
--%>



<%@page import="it.uniroma1.lcl.wcl.data.sentence.SentenceAnnotation"%>
<%@page import="it.uniroma1.lcl.wcl.data.sentence.Sentence"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.Scanner"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.nio.charset.Charset"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="it.uniroma1.lcl.wcl.classifiers.lattice.WCLClassifier"%>
<%@page import="it.uniroma1.lcl.wcl.classifiers.lattice.TripleLatticeClassifier"%>
<%@page import="it.uniroma1.lcl.wcl.data.dataset.AnnotatedDataset"%>
<%@page import="it.uniroma1.lcl.wcl.data.dataset.Dataset"%>
<%@page import="it.uniroma1.lcl.jlt.util.Language"%>
<%BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream("terms.txt"), "Cp1252"));// reading terms file

List<String> list = Files.readAllLines(new File("terms.txt").toPath(),Charset.defaultCharset() );
 Pattern PATTERN;
int i=0;
String search=null;

Sentence sentence;





        StringBuilder html = new StringBuilder();
html.append("<br/>");
html.append("<br/>");

   Language targetLanguage = Language.EN; 
   ArrayList<String> sentenceList = new ArrayList<String>();
           String[] SENTENCE;              
         Scanner sentence1 ;

        Dataset ts;
   String trainingDatasetFile ="data/training/wiki_good.EN.html";   //training data for WCL
       
      ts = new AnnotatedDataset(trainingDatasetFile, targetLanguage);
WCLClassifier c = new TripleLatticeClassifier(targetLanguage);
c.train(ts); 
                
 File  target_dir = new File("training");//reading all text files in the directory
            String contents=null;
            
                  
                
          for (File file : target_dir.listFiles()) {
                    
                   
       sentence1 = new Scanner(file );
            // text = text.replace("\n", "").replace("\r", "");

       while (sentence1.hasNextLine())
       {
           
           
           
           sentenceList.add(sentence1.nextLine().replace("\n", "").replace("\r", ""));
       }
                sentence1.close();
   
                }
       
  String[] sentenceArray = sentenceList.toArray(new String[sentenceList.size()]);
      String k =null;
  while (i < list.size()) {

  
    PATTERN = Pattern.compile(".*"+list.get(i).toLowerCase().trim()+".*"); //matching with term
       // search= list.get(i).toString().trim().toLowerCase();
       
        k=list.get(i);
         
 out.write("Searched Term: "+ k+html.toString()); //printing term
for (int r=0;r<sentenceArray.length;r++)  //for the content filtered based on term
  {

     SENTENCE = sentenceArray[r].split("\\.(?!\\d)\\s*"); //split sentences based on .? and store in array 
     
     // \t,.\n

     for (int j=0;j<SENTENCE.length;j++)
     {
         
         
          //if(SENTENCE[j].toLowerCase().indexOf(".*"+search.toLowerCase()+".*")!=-1)
         
      //  if (PATTERN.matcher(SENTENCE[j].toLowerCase()).matches())
         //{
            
       if(j>0 && !(SENTENCE[j].equals(SENTENCE[j-1]))) //checking duplicate sentence
       {
            //System.out.println("Sentence " + (r+1) + ": " + SENTENCE[j]);
             if(contents!= null && !contents.isEmpty())
             {
//                 if(!contents.toString().equalsIgnoreCase(contents.toString()))
//                 {
          contents+=" "+new StringBuilder().append(SENTENCE[j].toLowerCase()).toString(); //buliding string based on filtered sentences
//                 }
             }
            // test the sentence 
          else
             {
                 contents=new StringBuilder().append(SENTENCE[j].toLowerCase()).toString();
             }
             
             
         }
         
        
        
        
        
        
     
         
         }
         
         
  }  


//
                
//out.write(contents.toString()+html.toString());
 if(contents!= null && !contents.isEmpty())
             {
                 out.write(contents.toString()+html.toString());
 sentence = Sentence.createFromString(k.trim(),
contents.trim(), targetLanguage);
SentenceAnnotation sa = c.test(sentence);

if (sa.isDefinition())
//     
{
     
    
 out.write("found match "+sa.getHyper());
//
}  
             }
contents="";

i++;

  }
 


 








%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hypernym Extraction </title>
    </head>
    <body>
      
    </body>
</html>
