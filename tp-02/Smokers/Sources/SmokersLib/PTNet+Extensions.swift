import PetriKit

public class MarkingGraph {

    public let marking   : PTMarking
    public var successors: [PTTransition: MarkingGraph]

    public init(marking: PTMarking, successors: [PTTransition: MarkingGraph] = [:]) {
        self.marking    = marking
        self.successors = successors
    }

}

public extension PTNet {

    public func markingGraph(from marking: PTMarking) -> MarkingGraph? {
        // Write here the implementation of the marking graph generation.
				
        var NODE = MarkingGraph(marking: marking)
				
		var all_nodes = [NODE]
        var final_nodes = [MarkingGraph]()
		
		
        
        while let jetons_reseau = all_nodes.popLast() {
          
          final_nodes.append(jetons_reseau)
          
          for T in self.transitions {

            
				if let Markreseau = T.fire(from: jetons_reseau.marking) {
			
					print(marquage)
            
				if all_nodes.contains(where: {$0.marking == Markreseau}) {

					jetons_reseau.successors[T] = all_nodes.first(where: {$0.marking == Markreseau})
              
				}
              
				else if final_nodes.contains(where: {$0.marking == Markreseau}) {
                
					jetons_reseauF.successors[T] = final_nodes.first(where: {$0.marking == Markreseau})
            
				}
             
				else { var New_mark = MarkingGraph(marking: Markreseau)
			
					all_nodes.append(New_mark)
					jetons_reseau.successors[T] = New_mark
				
				}
            
				}
			
			}
        }
				
        return NODE
		
    }
}
