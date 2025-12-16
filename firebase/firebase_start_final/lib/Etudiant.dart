class Etudiant {
  final String nom;
  final String prenom;
  bool complete;

  Etudiant({
    required this.nom,
    required this.prenom,
    required this.complete,

  });

  factory Etudiant.fromJson(Map<String, dynamic> json, String documentId) {
    return Etudiant(
      nom: json['nom'] ?? '',
      prenom: json['prenom'] ?? '',
      complete: json['complete'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prenom': prenom,
      'complete': complete,
    };
  }
}