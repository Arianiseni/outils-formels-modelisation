import PetriKit

public extension PTNet {

// Il faut pouvoir retourner un graphe de couverture

  public func Graphe_de_Marquage (from marking: CoverabilityMarking) -> PTMarking {

    let Depart_Mark : Int = 0
	var Marquage : PTMarking = [:]
	
	
	  for i in self.places{

        Marquage[i] = 11

        for j in Depart_Mark...Marquage.count{

          if UInt(j) == marking[i]!{
            Marquage[i] = UInt(j)
          }
        
		}
      }

      return Marquage
}


public func Graphe_de_Couverture (from marking: PTMarking) -> CoverabilityMarking {


     var Mark : CoverabilityMarking = [:]

     for a in self.places{

       if marking[a] !<= 11{
         Mark[a] = .some(marking[a]!)
       } else{ Mark[i] = .omega}
	   
     }

     return Mark
}


    public func coverabilityGraph(from marking: CoverabilityMarking) -> CoverabilityGraph {
        // Write here the implementation of the coverability graph generation.

        // Note that CoverabilityMarking implements both `==` and `>` operators, meaning that you
        // may write `M > N` (with M and N instances of CoverabilityMarking) to check whether `M`
        // is a greater marking than `N`.

        // IMPORTANT: Your function MUST return a valid instance of CoverabilityGraph! The optional
        // print debug information you'll write in that function will NOT be taken into account to
        // evaluate your homework.
		

	 var Graphe_Couv = [CoverabilityGraph]()
	 var MarkGraphInit = [Marquage]
	
	 let Node = MarkGraphInit.popLast()
	

        while Node {

          Graphe_Couv.append(Node)

          for b in self.transitions {

            if b.fire(from: Graphe_de_Marquage(from: Node.marking)) != nil{
              let Marquage_initial = b.fire(from: Graphe_de_Marquage(from: Node.marking))
              var Marquage_etape = Graphe_de_Couverture(from: Marquage_initial!)

              for Update in Marquage{

                    if Marquage_etape > Update.marking{

                      for c in self.places{

                        if Marquage_etape[c]! > Update.marking[c]!{
                           Marquage_etape[c] = .omega
                        }

                      }
                    }

                }

              if MarkGraphInit.contains(where: {$0.marking == Marquage_etape}) {
                Node.successors[b] = MarkGraphInit.first(where: {$0.marking == Marquage_etape})
              } else if M.contains(where: {$0.marking == Marquage_etape}) {
						Node.successors[b] = M.first(where: {$0.marking == Marquage_etape})
						} else { 
							let MarquageUpdate = CoverabilityGraph(marking : Marquage_etape)
							Node.successors[b] = MarquageUpdate
							MarkGraphInit.append(MarquageUpdate)
							}

            }

          }

        }
	
        return CoverabilityGraph(marking: marking)
		return Marquage
	}

}
