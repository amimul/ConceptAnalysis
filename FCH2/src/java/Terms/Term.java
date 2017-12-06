/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Terms;

/**
 *
 * @author jean
 */


import fr.univnantes.termsuite.api.ExtractorOptions;
import fr.univnantes.termsuite.api.TXTCorpus;
import fr.univnantes.termsuite.api.TermOrdering;
import fr.univnantes.termsuite.api.TermSuite;
import fr.univnantes.termsuite.framework.TermSuiteFactory;
import fr.univnantes.termsuite.framework.service.TerminologyService;
import fr.univnantes.termsuite.index.Terminology;
import fr.univnantes.termsuite.io.tsv.TsvOptions;
import fr.univnantes.termsuite.model.IndexedCorpus;
import fr.univnantes.termsuite.model.Lang;
import fr.univnantes.termsuite.model.TermProperty;
import fr.univnantes.termsuite.utils.TermHistory;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
public class Term {
    
  
   
   
public  ArrayList<String> extraction() 
{
    
    
       
        TXTCorpus corpus = new TXTCorpus(
    Lang.EN,
    Paths.get("training"));
        
        
        // Do the NLP preprocessings


  IndexedCorpus corpus1 = TermSuite.preprocessor()
    .setTaggerPath(Paths.get("TreeTagger"))
    .toIndexedCorpus(corpus, 5000000);


   
      TermSuite.terminoExtractor().execute(corpus1);
TermHistory history = new TermHistory();

// Keep only top 1000 terms by specificity with their variants
TermSuite.terminologyFilterer()
    .by(TermProperty.SPECIFICITY)
    .keepTopN(500).keepVariants()
    .filter(corpus1);

Terminology termino = corpus1.getTerminology();
  ArrayList<String> sortedTerms = new ArrayList<>();
      
TerminologyService terminologyService = TermSuite.getTerminologyService(termino);
terminologyService.terms(TermOrdering.natural()).forEach(t -> {
   
   
sortedTerms.add(t.getPilot());
   
       });


       
return sortedTerms;
    
    
}
}
