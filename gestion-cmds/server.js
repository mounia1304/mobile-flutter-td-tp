const express = require('express');
const fs = require('fs');

const app = express();
const PORT = 3000;

app.use(express.json());

const readData = (filename) => {
    if (!fs.existsSync(filename)) return [];
    return JSON.parse(fs.readFileSync(filename, 'utf8'));
};

const writeData = (filename, data) => {
    fs.writeFileSync(filename, JSON.stringify(data, null, 2));
};

// GET - Récupérer tous les produits
app.get('/produits', (req, res) => {
    const produits = readData('produits.json');
    res.json(produits);
});

// POST - Ajouter un nouveau produit
app.post('/produits', (req, res) => {
    const produits = readData('produits.json');
    const newProduit = req.body;
    produits.push(newProduit);
    writeData('produits.json', produits);
    res.json({ message: 'Produit ajouté avec succès !', produit: newProduit });
});

// GET - Récupérer toutes les commandes
app.get('/commandes', (req, res) => {
    const commandes = readData('commandes.json');
    res.json(commandes);
});

// POST - Ajouter une nouvelle commande
app.post('/commandes', (req, res) => {
    const commandes = readData('commandes.json');
    const newCommande = req.body;
    commandes.push(newCommande);
    writeData('commandes.json', commandes);
    res.json({ message: 'Commande ajoutée avec succès !', commande: newCommande });
});

app.listen(PORT, () => {
    console.log(`Serveur démarré sur http://localhost:${PORT}`);
});

