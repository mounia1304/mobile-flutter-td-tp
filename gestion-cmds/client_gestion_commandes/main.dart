import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiUrl = "http://localhost:3000";

// Définition de la classe Produit
class Produit {
  String nom;
  double prix;
  int stock;
  String categorie;

  Produit({required this.nom, required this.prix, required this.stock, required this.categorie});

  factory Produit.fromJson(Map<String, dynamic> json) {
    return Produit(
      nom: json['nom'],
      prix: json['prix'].toDouble(),
      stock: json['stock'],
      categorie: json['categorie'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prix': prix,
      'stock': stock,
      'categorie': categorie,
    };
  }
}

// Fonction pour récupérer et afficher tous les produits
Future<void> getProduits() async {
  var response = await http.get(Uri.parse('$apiUrl/produits'));
  if (response.statusCode == 200) {
    List produits = jsonDecode(response.body);
    produits.forEach((p) => print("Produit: ${p['nom']}, Prix: ${p['prix']} DH"));
  } else {
    print("Erreur lors de la récupération des produits");
  }
}

// Fonction pour ajouter un produit
Future<void> addProduit(Produit produit) async {
  var response = await http.post(
    Uri.parse('$apiUrl/produits'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(produit.toJson()),
  );
  if (response.statusCode == 200) {
    print("Produit ajouté avec succès !");
  } else {
    print("Erreur lors de l'ajout du produit");
  }
}

// Fonction pour récupérer et afficher toutes les commandes
Future<void> getCommandes() async {
  var response = await http.get(Uri.parse('$apiUrl/commandes'));
  if (response.statusCode == 200) {
    List commandes = jsonDecode(response.body);
    commandes.forEach((c) => print("Commande: ${c['id']}, Total: ${c['total']}"));
  } else {
    print("Erreur lors de la récupération des commandes");
  }
}

// Fonction pour ajouter une commande
Future<void> addCommande(Map<String, dynamic> commande) async {
  var response = await http.post(
    Uri.parse('$apiUrl/commandes'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(commande),
  );
  if (response.statusCode == 200) {
    print("Commande ajoutée avec succès !");
  } else {
    print("Erreur lors de l'ajout de la commande");
  }
}

void main() async {
  // Récupérer et afficher les produits
  await getProduits();

  // Ajouter un produit
  await addProduit(Produit(nom: "Laptop", prix: 12000, stock: 10, categorie: "Electronics"));

  // Récupérer et afficher les produits après ajout
  await getProduits();

  // Récupérer et afficher les commandes
  await getCommandes();

  // Ajouter une commande (exemple simple)
  await addCommande({
    "id": 1,
    "produits": [{"id": 1, "quantite": 2}],  // Exemple de produit commandé
    "total": 24000
  });

  // Récupérer et afficher les commandes après ajout
  await getCommandes();
}
