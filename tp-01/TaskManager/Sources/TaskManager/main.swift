import TaskManagerLib
�
let taskManager = createTaskManager()

// PARTIE 3 : ANALYSE DU PROBLEME
//
// Tout d'abord, on doit r�cup�rer les places et les transitions :
//
// Places initiales :

let taskPool ���= taskManager.places.first { $0.name == "taskPool" }!
let processPool = taskManager.places.first { $0.name == "processPool" }!
let inProgress �= taskManager.places.first { $0.name == "inProgress" }!

// Transitions initiales :

let create �����= taskManager.transitions.first { $0.name == "create" }!
let spawn ������= taskManager.transitions.first { $0.name == "spawn" }!
let exec �������= taskManager.transitions.first { $0.name == "exec" }!
let success ����= taskManager.transitions.first { $0.name == "success" }!
let fail �������= taskManager.transitions.first { $0.name == "fail" }!


// Notre probl�me est qu'on peut se retrouver avec 2 processus sortant de EXEC,
// alors que nous n'avons qu'une t�che � effectuer. 
// Maintenant, on peut donner l'exemple qui conduit au probl�me d�crit dans le TP :

let marquage1 = create.fire(from: [taskPool: 0, processPool: 0, inProgress: 0])
let marquage2 = spawn.fire(from: marquage1 !)
let marquage3 = spawn.fire(from: marquage2 !)
let marquage4 = exec.fire(from: marquage3 !)
let marquage5 = exec.fire(from: marquage4 !)
let marquage6 = success.fire(from: marquage5 !)


// Pour v�rifier que tout se passe bien, on peut afficher les valeurs des marquages :

print("Marquage 1 =",marquage1!)
print("Marquage 2 =",marquage2!)
print("Marquage 3 =",marquage3!)
print("Marquage 4 =",marquage4!)
print("Marquage 5 =",marquage5!)
print("Marquage 6 =",marquage6!)


// PARTIE 4 : CORRECTION DU PROBLEME

�
let correctTaskManager = createCorrectTaskManager()
�

// Places initiales avec ajout de notre place Debg_Task :
�
let correctTaskPool ���= correctTaskManager.places.first { $0.name == "taskPool" }!
let correctProcessPool = correctTaskManager.places.first { $0.name == "processPool" }!
let correctInProgress �= correctTaskManager.places.first { $0.name == "inProgress" }!
let correctDebg_Task ��= correctTaskManager.places.first { $0.name == "Debg_Task" }!


// Transitions inchang�es :

let correctCreate �����= correctTaskManager.transitions.first { $0.name == "create" }!
let correctSpawn ������= correctTaskManager.transitions.first { $0.name == "spawn" }!
let correctExec �������= correctTaskManager.transitions.first { $0.name == "exec" }!
let correctSuccess ����= correctTaskManager.transitions.first { $0.name == "success" }!
let correctFail �������= correctTaskManager.transitions.first { $0.name == "fail" }!
�

// Maintenant, on peut tester notre r�seau avec la nouvelle place :

let marquage_corr1 = correctCreate.fire(from: [correctTaskPool: 0, correctProcessPool: 0, correctInProgress: 0, correctDebg_Task: 1])
let marquage_corr2 = correctSpawn.fire(from: marquage_corr1!)
let marquage_corr3 = correctSpawn.fire(from: marquage_corr2!)
let marquage_corr4 = correctExec.fire(from: marquage_corr3!)
let marquage_corr5 = correctExec.fire(from: marquage_corr4!)
let marquage_corr6 = correctSuccess.fire(from: marquage_corr5!)


// Comme pour l'erreur, on peut afficher les valeurs des marquages pour v�rifier si tout se passe bien :

print("Marquage_correction 1 =",m21!)
print("Marquage_correction 2 =",m22!)
print("Marquage_correction 3 =",m23!)
print("Marquage_correction 4 =",m24!)
print("Marquage_correction 5 =",m25!)
print("Marquage_correction 6 =",m26!)
