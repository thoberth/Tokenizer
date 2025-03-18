# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a Hardhat Ignition module that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat ignition deploy ./ignition/modules/Lock.js
```

# Contrat hitmanThoberth42

## Description Générale

Le contrat `hitmanThoberth42` est un contrat intelligent ERC-20 qui permet de proposer, d'accepter et de gérer des offres de service avec paiement en jetons. Ce contrat est construit sur la plateforme Ethereum et étend les fonctionnalités standards des jetons ERC-20 avec un système de gestion d'offres de service.

## Caractéristiques du Jeton

- **Nom**: hitmanThoberth42
- **Symbole**: HT42
- **Décimales**: 18 (standard ERC-20)
- **Propriétaire**: L'adresse qui déploie le contrat devient le propriétaire initial

## Structure de Données

### ServiceOffer

Une structure qui représente une offre de service avec les propriétés suivantes:

- `provider`: L'adresse du fournisseur du service (payable)
- `price`: Le prix du service en jetons HT42
- `isCompleted`: Un indicateur booléen qui montre si le service a été complété

## Variables d'État

- `offer`: L'offre de service active
- `customer`: L'adresse du client qui a accepté l'offre
- `offerAccepted`: Indique si l'offre a été acceptée
- `serviceRefunded`: Indique si le service a été remboursé

## Événements

- `OfferCreated`: Émis lorsqu'une nouvelle offre est créée (paramètres: provider, price)
- `OfferAccepted`: Émis lorsqu'une offre est acceptée par un client (paramètre: customer)
- `ServiceCompleted`: Émis lorsqu'un service est marqué comme complété
- `ServiceRefunded`: Émis lorsqu'un service est remboursé (paramètres: customer, amount)

## Fonctions

### Constructor

```solidity
constructor(uint256 initialSupply) Ownable(msg.sender) ERC20("hitmanThoberth42", "HT42")
```

Initialise le contrat avec une offre d'approvisionnement initial de jetons.

- `initialSupply`: La quantité initiale de jetons à créer et à attribuer au déployeur du contrat

### createOffer

```solidity
function createOffer(uint256 _price) public onlyOwner
```

Permet au propriétaire du contrat de créer une nouvelle offre de service.

- `_price`: Le prix du service en jetons HT42
- **Restrictions**: Peut uniquement être appelée par le propriétaire du contrat
- **Conditions**: Aucune offre active ne doit exister ou l'offre précédente doit être complétée

### acceptOffer

```solidity
function acceptOffer() public
```

Permet à un utilisateur d'accepter l'offre de service en cours.

- **Conditions**:
  - Une offre doit exister
  - L'offre ne doit pas avoir déjà été acceptée
  - Le service ne doit pas être déjà complété
  - L'utilisateur doit avoir suffisamment de jetons pour payer le service
- **Effets**: Transfère les jetons du client au fournisseur de service

### completeService

```solidity
function completeService() public onlyProvider
```

Permet au fournisseur de service de marquer le service comme complété.

- **Restrictions**: Peut uniquement être appelée par le fournisseur de service
- **Conditions**:
  - L'offre doit avoir été acceptée
  - Le service ne doit pas être déjà complété
  - Le service ne doit pas avoir été remboursé

### refund

```solidity
function refund() public onlyCustomer
```

Permet au client de demander un remboursement pour un service non complété.

- **Restrictions**: Peut uniquement être appelée par le client
- **Conditions**:
  - L'offre doit avoir été acceptée
  - Le service ne doit pas être déjà complété
  - Le service ne doit pas avoir déjà été remboursé
- **Effets**: Transfère les jetons du fournisseur de service au client

## Modifiers

### onlyProvider

```solidity
modifier onlyProvider()
```

Vérifie que le message provient du fournisseur de service.

### onlyCustomer

```solidity
modifier onlyCustomer()
```

Vérifie que le message provient du client qui a accepté l'offre.

## Cas d'Utilisation

Ce contrat peut être utilisé pour:
- Offrir des services payés en jetons HT42
- Gérer des accords de service avec garantie de paiement
- Permettre des remboursements en cas de non-exécution du service

## Sécurité

Le contrat utilise les bibliothèques OpenZeppelin pour les fonctionnalités de base des jetons ERC-20 et la gestion de la propriété, ce qui assure un niveau élevé de sécurité et de conformité aux standards. Les vérifications d'autorisations et de conditions sont implémentées pour chaque fonction sensible.


# Fonctions de base ERC-20 et Ownable

## Fonctions de base ERC-20

1. **transfer(address to, uint256 amount)**
   - Permet de transférer des tokens à une autre adresse
   - Retourne un booléen indiquant si le transfert a réussi

2. **approve(address spender, uint256 amount)**
   - Autorise un tiers (spender) à utiliser une certaine quantité de vos tokens
   - Retourne un booléen indiquant si l'approbation a réussi

3. **transferFrom(address from, address to, uint256 amount)**
   - Permet à une adresse approuvée de transférer des tokens entre deux autres adresses
   - Retourne un booléen indiquant si le transfert a réussi

4. **balanceOf(address account)**
   - Retourne le nombre de tokens détenus par une adresse

5. **allowance(address owner, address spender)**
   - Retourne le montant que le spender est autorisé à utiliser au nom du owner

6. **totalSupply()**
   - Retourne le nombre total de tokens en circulation

7. **decimals()**
   - Retourne le nombre de décimales du token (généralement 18)

8. **name()**
   - Retourne le nom du token ("hitmanThoberth42" dans votre cas)

9. **symbol()**
   - Retourne le symbole du token ("HT42" dans votre cas)

## Fonctions de base Ownable

1. **owner()**
   - Retourne l'adresse du propriétaire actuel du contrat

2. **transferOwnership(address newOwner)**
   - Transfère la propriété du contrat à une nouvelle adresse
   - Seul le propriétaire actuel peut appeler cette fonction

3. **renounceOwnership()**
   - Permet au propriétaire de renoncer à la propriété du contrat
   - Cette action est irréversible

4. **onlyOwner modifier**
   - Un modificateur qui restreint l'accès à une fonction uniquement au propriétaire du contrat
   - C'est ce que vous utilisez dans votre fonction `createOffer`
