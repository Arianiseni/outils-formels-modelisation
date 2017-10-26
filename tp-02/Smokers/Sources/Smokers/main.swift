import PetriKit
import SmokersLib

// Instantiate the model.
let model = createModel()

// Retrieve places model.
guard let r  = model.places.first(where: { $0.name == "r" }),
      let p  = model.places.first(where: { $0.name == "p" }),
      let t  = model.places.first(where: { $0.name == "t" }),
      let m  = model.places.first(where: { $0.name == "m" }),
	  
      let w1 = model.places.first(where: { $0.name == "w1" }),
      let s1 = model.places.first(where: { $0.name == "s1" }),
      let w2 = model.places.first(where: { $0.name == "w2" }),
      let s2 = model.places.first(where: { $0.name == "s2" }),
      let w3 = model.places.first(where: { $0.name == "w3" }),
      let s3 = model.places.first(where: { $0.name == "s3" }),
	  
	  // Ajout de places et transitions
	  
	  let tpt = model.transitions.first(where: { $0.name == "tpt" }),
      let tpm = model.transitions.first(where: { $0.name == "tpm" }),
      let ttm = model.transitions.first(where: { $0.name == "ttm" }),
	  
	  let tw1 = model.transitions.first(where: { $0.name == "tw1" }),
      let tw2 = model.transitions.first(where: { $0.name == "tw2" }),
      let tw3 = model.transitions.first(where: { $0.name == "tw3" }),
	  
      let ts1 = model.transitions.first(where: { $0.name == "ts1" }),
      let ts2 = model.transitions.first(where: { $0.name == "ts2" }),
      let ts3 = model.transitions.first(where: { $0.name == "ts3" })
  	  
else {
    fatalError("invalid model")
}

// Create the initial marking.
let initialMarking: PTMarking = [r: 1, p: 0, t: 0, m: 0, w1: 1, s1: 0, w2: 1, s2: 0, w3: 1, s3: 0]

// Deux variables pour vérifier le nombre de fumeurs et d'ingrédients sur la table :
// Une autre pour le nombre de fumeurs totaux :

var Ingredient_alone = true
var Smoker_alone = true
var Smokers = 0

func countNodes(markingGraph: MarkingGraph)-> Int {

// Comme vu en classe, on peut implémenter une boucle while :

	var seen = [markingGraph]
	var toVisit = [markingGraph]

	while let actualNodes = toVisit.popLast() {
		
		for (_, successor) in actualNodes.successors {
			
			if !seen.contains(where: { $0 === successor }) {
			seen.append(successor)		    
			toVisit.append(successor)

		for (actualPlace, totalJetons) in actualNodes.marking{
		
				if actualPlace == s1 || actualPlace == s2 || actualPlace == s3 {
			
				Smokers = Smokers + 1
			
				}
					  
				if totalJetons > 1 && (actualPlace == p || actualPlace == t || actualPlace == m) {
				
				Ingredient_alone = false
				
				}
			
        }
				if Smokers > 1 {
				
				Smoker_alone = false
				
				}
			}	
		}
	}
	
	return seen.count

}



// Create the marking graph (if possible).
if let markingGraph = model.markingGraph(from: initialMarking) {
    // Write here the code necessary to answer questions of Exercise 4.
	
	// EXERCICE 4 : QUESTIONS
	// 1. Combien d'états différents votre réseau peut-il avoir ?
	// 2. Est-il possible que deux fumeurs différents fuments en même temps ?
	// 3. Est-il possible d'avoir deux fois le même ingrédient sur la table ?
	
	// REPONSES
	// 1. Il suffit de print la fonction qui calcule les marquages
	print( "Marquages :",countNodes(markingGraph: markingGraph) )
	
	// 2. Il suffit d'utiliser la variable créé pour voir s'il n'y a qu'un fumeur :
	if Smoker_alone == true {
	
		print( "Hourra, il n'y a qu'un fumeur de cigare !" )
		
	else { print( "Mince, il y a malheureusement plus d'un fumeur au même moment..." ) }
	
	}
	
	// 3. Il suffit d'utiliser la variable créé pour voir s'il n'y a qu'un ingrédient :
	if Smoker_alone == true {
	
		print( "Parfait, il n'y a qu'une seule fois le même ingrédient !" )
		
	else { print( "Oups, un ingrédient apparaît deux fois..." ) }
	
	}
		
}
