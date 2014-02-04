# Guide des feuilles de styles CSS, conseils et bonnes pratiques

---

## Traductions

* [русский](https://github.com/matmuchrapna/CSS-Guidelines/blob/master/README%20Russian.md)
* [English](https://github.com/csswizardry/CSS-Guidelines)

---

En travaillant sur de grands projets d'envergure fonctionnant avec des dizaines de développeurs, il est important que nous travaillions tous de façon unifiée avec pour objectif de :

* Garder les feuilles de style maintenables
* Garder le code transparent et lisible
* Garder les feuilles de style extensibles

Il existe plusieurs techniques que nous devons employer pour satisfaire ces objectifs.

La première partie de ce document traitera de la syntaxe, du formatage et de la taxonomie CSS.
La deuxième partie traitera de l'approche, l'état d'esprit et l'attitude à avoir pour écrire et architecturer du CSS.
Passionnant, hein?

## Contenu

* [Anatomie d'un document CSS](#anatomie-dun-document-css)
  * [Généralités](#gnralits)
  * [Un seul fichier ou plusieurs fichiers ?](#un-seul-fichier-ou-plusieurs-fichiers-)
  * [Table des matières](#table-des-matires)
  * [Titre de section](#titres-de-section)
* [Ordre des sources](#ordre-des-sources)
* [Anatomie d'une règle](#anatomie-dune-rgle)
* [Classes en HTML](#classes-en-html)
* [Convention de nommage](#convention-de-nommage)
  * [Classes en HTML](#classes-en-html)
  * [Ancres javascript](#ancres-javascript)
  * [Localisation](#localisation)
* [Commentaires](#commentaires)
  * [Commentaires sous stéroïdes](#commentaires-sous-strodes)
  * [Sélecteurs spécifiques](#selecteurs-specifiques)
  * [Code des balises](#code-des-balises)
  * [Association des objets](#association-des-objets)
* [Ecrire du CSS](#ecrire-du-css)
* [Construire de nouveaux composants](#construire-de-nouveau-composants)
* [CSSOO](#cssoo)
* [Mise en page](#mise-en-page)
* [Taille des interfaces](#taille-des-interfaces)
  * [Taille des polices](#taille-des-polices)
* [Raccourcis](#raccourcis)
* [IDs](#ids)
* [Sélecteurs](#selecteurs)
  * [Sur-qualification des sélecteurs](#sur-qualification-des-selecteurs)
  * [Performance des sélecteurs](#performance-des-selecteurs)
* [L'intention de sélection](#lintention-de-selection)
* [`!important`](#important)
* [Nombres magiques et absolus](#nombres-magiques-et-absolus)
* [Styles conditionnels](#styles-conditionnels)
* [Débogage](#debogage)
* [Pré-processeurs](#pre-processeurs)

---

## Anatomie d'un document CSS

Peu importe le document, il faut toujours essayer de garder un formatage commun.
Cela signifie une cohérence des commentaires, de la syntaxe et des règles de nommage.

### Généralités

Limitez vos feuilles de style avec un maximum de 80 caractères de longueur lorsque cela est possible. Des exceptions peuvent être la syntaxe des dégradés ainsi que les URL dans les commentaires. Il n'y a rien que nous puissions faire à ce sujet.

Concernant l'indentation je préfère 2 espaces au lieu des tabulations et écrire
sur plusieurs lignes CSS.

### Un seul fichier ou plusieurs fichiers ?

Certaines personnes préfèrent travailler avec de simples fichiers volumineux.
Cela fonctionne très bien pour les petits projets mais avec les directives suivantes vous aller très vite rencontrer des problèmes.
Depuis l'arrivée de sass, j'ai commencé à séparer mes feuilles de styles en petits fichiers. Cette méthode est aussi très bonne. Quelle que soit la méthode que vous choisissez, les règles suivantes et les lignes directrices s'appliquent. La seule différence notable est en ce qui concerne notre table des matières et nos titres de section. Lisez la suite pour plus d'explications...

### Table des matières

Au sommet des feuilles de style, je maintiens une table des matières qui détaillera les sections contenues dans le document, par exemple :

    /*------------------------------------*\
        $CONTENU
    \*------------------------------------*/
    /**
     * CONTENU.............Vous êtes en train de le lire
     * RESET...............Réinitialisation des styles par défaut
     * FONT................Les polices de caractère
     */

Ceci va permettre au prochain développeur de savoir exactement ce qu'il va trouver dans ce fichier. Chaque élément de la table des matières correspond directement à un titre de section.

Si vous travaillez sur une grande feuille de style, la section correspondante sera également dans ce fichier. Si vous travaillez sur plusieurs fichiers, chaque élément de la table des matières correspondra à une inclusion.

### Titres de section

La table des matières n'est d'aucune utilité si elle ne possède pas de section
correspondante. Les sections sont désignées ainsi :

    /*------------------------------------*\
        $RESET
    \*------------------------------------*/

Le préfixe `$` dans une section permet de faire une recherche rapide ([Cmd|Ctrl]+F ou ([Ctrl|Shift]+F))

Si vous travaillez dans une grande feuille de style, laissez cinq (5) retours chariot entre chaque section, comme ceci :

    /*------------------------------------*\
        $RESET
    \*------------------------------------*/
    [Vos
    styles
    par défaut]





    /*------------------------------------*\
        $FONT
    \*------------------------------------*/

Ce gros morceau d'espaces est rapidement perceptible lorsque vous faites défiler des fichiers plus volumineux.

Si vous travaillez sur plusieurs feuilles de styles, démarrez chacun de ces
fichiers avec un titre de section. Il n'est pas nécessaire d'inclure des retours
chariot.

## Ordre des sources

Essayez d'écrire des feuilles de style dans leur ordre de spécificité. Cela garantit que vous conservez l'avantage de l'héritage ainsi que le <i>C</i> du CSS qui signifie cascade.

Une feuille de style bien ordonnée ressemblera à ceci :

1. **Reset** – réinitialisation des propriétés.
2. **Elements** – propriétés de bases `h1`, `ul` etc.
3. **Objets et abstractions** — patrons de conception génériques.
4. **Composants** – composants complets construits à partir d'objets et de leurs extensions.
5. **Atouts de style** – états des erreurs etc.

Cela signifie que lorsque vous descendez dans le document, chaque section s'appuie et hérite de la précédente. Il devrait y avoir moins d'annulations de styles, moins de problèmes de spécificité, moins de créations de style tous azimuts et une meilleure architecture de vos feuilles.

Pour en savoir plus, je vous recommande chaudement de lire [SMACSS](http://smacss.com) de Jonathan Snook.

## Anatomie d'une règle

    [selecteur]{
        [propriété]:[valeur];
        [<- Déclaration ->]
    }

J'applique un certain nombre de normes concernant la structure des règles CSS.

* Utiliser `-` pour délimiter les noms de classe (sauf pour cet exemple de
  [convention de nommage](#naming-conventions))
* 2 espaces d'indentation
* Multi-ligne
* Déclaration par ordre de pertinence (et non alphabétique)
* Indenter les déclarations de préfixes et aligner leurs valeurs
* Indenter les règles en reflètant le DOM
* Toujours inclure le point-virgule final

Un petit exemple :

    .widget{
        padding:10px;
        border:1px solid #BADA55;
        background-color:#C0FFEE;
        -webkit-border-radius:4px;
           -moz-border-radius:4px;
                border-radius:4px;
    }
        .widget-heading{
            font-size:1.5rem;
            line-height:1;
            font-weight:bold;
            color:#BADA55;
            margin-right:-10px;
            margin-left: -10px;
            padding:0.25em;
        }

Ici, nous pouvons voir que `.widget-heading` doit être un enfant de `.widget`
que nous avons indenté `.widget-heading` d'un niveau plus profond que `.widget`.
C'est une information utile pour les développeurs qui peut être scannée
seulement d'un coup d'oeil suivant l'indentation de notre ensemble de règles.

Nous pouvons également voir que les déclarations de `.widget-heading` sont triées par leur pertinence. `.widget-heading` doit être un élément textuel si nous commençons avec nos règles de texte, suivies par toutes les autres.

Une exception à notre règle multi-lignes pourrait être dans le cas suivant :

    .t10    { width:10% }
    .t20    { width:20% }
    .t25    { width:25% }       /* 1/4 */
    .t30    { width:30% }
    .t33    { width:33.333% }   /* 1/3 */
    .t40    { width:40% }
    .t50    { width:50% }       /* 1/2 */
    .t60    { width:60% }
    .t66    { width:66.666% }   /* 2/3 */
    .t70    { width:70% }
    .t75    { width:75% }       /* 3/4*/
    .t80    { width:80% }
    .t90    { width:90% }

Dans cet exemple (extrait du système de grille d'[inuit.css](
https://github.com/csswizardry/inuit.css/blob/master/inuit.css/partials/base/_tables.scss#L88)), il est plus logique de tout concentrer sur une seule ligne.

## Convention de nommage

La plupart du temps, j'utilise simplement des classes délimités par des traits
d'union (ex. `.Foo-bar`, pas `.foo_bar` ou `.FooBar`), mais dans certaines
circonstances, j'utilise la notation BEM (Block, Élément, Modifieur).

<abbr title="Block, Element, Modifier">BEM</abbr> est une méthode pour nommer et classifier vos sélecteurs CSS de façon à les rendre beaucoup plus strict, transparent et informatif.

La convention de nommage suit ce modèle :

    .block{}
    .block__element{}
    .block--modifieur{}

* `.block` représente le niveau supérieur d'une abstraction ou d'un composant.
* `.block__element` représente un descendant de `.bloc` puisqu'il contribue à former `.bloc` dans son ensemble.
* `.block--modifieur` représente un état ou une version différente de `.block`.

Une **analogie** du fonctionnement de la méthode BEM :

    .personne{}
    .personne--femme{}
        .personne__main{}
        .personne__main--gauche{}
        .personne__main--droite{}

Ici, nous pouvons voir que l'objet de base que nous décrivons est une personne, et qu'un autre type de personne pourrait être une femme. Nous pouvons également voir que les gens ont des mains, ce sont des sous-parties des personnes, et il y a différentes variantes, comme main gauche et main droite.

Nous pouvons maintenant nommer nos sélectionneurs en fonction de leurs objets de base et nous pouvons également savoir ce que le sélecteur fait, est-il un sous-composant (`__`) ou une variation (`--`)?

Ainsi, `.page-wrapper` est un sélecteur autonome, il ne fait pas partie d'une
abstraction ou d'un composant et comme tel il nommé correctement.
Toutefois, `.widget-heading` _est_ lié à un composant, c'est un enfant du constructeur `.widget`.
Nous devrions renommer cette classe `.widget__heading`.

La notation BEM est un peu laide, plus verbeuse, mais elle nous donne beaucoup plus de pouvoirs dans le glanage d'informations sur les fonctions et sur les relations entre les éléments, uniquement avec leur nom de classes. En outre, la syntaxe BEM sera généralement très bien compressée (gzip) puisqu'elle favorise / fonctionne bien avec la répétition.

Peu importe si vous avez besoin d'utiliser BEM ou non, assurez-vous de toujours nommer vos classes judicieusement ; garder un nom aussi court que possible, mais aussi long que nécessaire. S'assurer que les objets ou les abstractions sont très vaguement nommés (par exemple `.ui-list`, `.media`) pour permettre une meilleure réutilisation. Les extensions des objets devraient être nommées beaucoup plus explicitement (par exemple `.user-avatar-link`). Ne vous inquiétez pas du montant ou de la taille de vos classes, gzip compresse le code bien écrit _incroyablement_ bien.

### Classes en HTML

Dans le but de rendre les choses plus faciles à lire, séparez les classes dans
votre HTML avec deux (2) espaces :

    <div class="foo--bar  bar__baz">

L'augmentation des espaces blancs devrait faciliter le repérage et la lecture
de plusieurs classes.

### Ancres Javascript

**N'utilisez jamais une classe de _style_ CSS pour vos ancres Javascript**
Associer un comportement javascript à une classe de style signifie que nous ne pourrons jamais avoir l'un sans l'autre.

Si vous avez besoin de se lier un évènement à une balise, créez une classe JS dans votre CSS. Il s'agit simplement d'une classe avec un nommage `.js-`, par exemple `.js-toggle`, `.js-drag-and-drop`. Cela signifie que nous pouvons joindre les deux classes JS et CSS pour notre balisage, sans avoir de chevauchements gênants.

    <th class="is-sortable  js-is-sortable">
    </th>

Le balisage ci-dessus contient deux classes ; la première est associée au style du tableau, la deuxième à une fonction de tri.

### Localisation

En dépit d'être un développeur britannique, je passe ma vie à écrire <i>colour</i> au lieu de <i>color</i>. Je pense que, dans un souci de cohérence, il est préférable d'utiliser toujours un anglais Américain en CSS. CSS, comme avec la plupart (sinon tous) les autres langages, est écrit en anglais-US. Mélanger une syntaxe `color: red;` avec des classes comme `.colour-picker{}` peut manquer de cohérence.
J'ai déjà proposé et défendu une écriture des classes bilingues,

    .color-picker,
    .colour-picker{
    }

Cependant, après avoir récemment travaillé sur un projet de grande envergure en Sass où il y avait des dizaines de variables de couleur (par exemple `$brand-color`, `$highlight-color` etc.), maintenir deux versions de chaque variable est vite devenu ennuyeux. Cela signifie également deux fois plus de travail avec des choses comme "rechercher et remplacer".

Dans un souci de cohérence, nommez toujours vos classes et vos variables dans les paramètres régionaux de la langue que vous utilisez.

Vous pouvez aussi vous mettre d'accord avec votre équipe de développement pour n'utiliser que de l'anglais pour vos projets. Cela vous permettra d'améliorer votre maîtrise de la langue de Shakespeare.

## Commentaires

J'utilise un style de commentaire docBlock où la taille est limitée à 80 caractères :

    /**
     * Ceci est un commentaire de style DocBlock
     *
     * Ceci est une description plus détaillée
     * Nous limitons ces lignes pour un maximum de 80 caractères.
     *
     * Nous pouvons avoir des balises dans les commentaires :
     *
       <div class=foo>
           <p>Lorem</p>
       </div>
     *
     * Nous n'avons pas de préfixe avec une étoile pour faciliter le
     * copier-coller.
     */

Vous devez documenter et commenter votre code autant que vous le pouvez, quoi qu'il arrive. Cela peut sembler trop transparent ou explicite pour vous mais peut-être pas pour un autre dev. Chaque nouveau morceau de code doit-être documenté.

### Commentaires sous stéroïdes

Il y a un certain nombre de techniques plus avancées que vous pouvez employer en ce qui concerne les commentaires, à savoir :

* Les sélecteurs spécifiques
* Le codage des balises
* l'association des objets

#### Sélecteurs spécifiques

Vous ne devriez jamais qualifier vos sélecteurs, c'est-à-dire que nous ne devrions jamais écrire `ul.nav{}` si vous pouvez juste avoir `.nav`. Qualifier vos sélecteurs diminue leur rendement, inhibe le potentiel de réutilisation d'un objet sur un autre type d'élément et augmente la spécificité du sélecteur. Ce sont toutes des choses qui doivent être évitées à tout prix.

Cependant, il est parfois utile de communiquer à d'autre(s) développeur(s) où
vous avez l'intention d'utiliser une classe. Prenons `.product-page` par exemple, cette classe sonne comme si elle était utilisée sur un conteneur de haut niveau, peut-être avec `html` ou `body`, mais seulement avec `.product-page` il est impossible de le savoir.

Par quasi-qualification de ce sélecteur (autrement dit en commentant le sélecteur de premier plan), nous pouvons communiquer nos intentions pour cette classe :

    /*html*/.product-page{}

Nous pouvons maintenant voir exactement où s'applique cette classe, sans avoir les inconvénients de la la spécificité ou de la non-réutilisation.

D'autres exemples pourraient être: :

    /*ol*/.breadcrumb{}
    /*p*/.intro{}
    /*ul*/.image-thumbs{}

Dans ces cas, nous savons le contexte d'utilisation de ces classes sans jamais impacter la spécificité des sélecteurs

#### Code des balises

Si vous écrivez un nouveau composant, laissez certaines balises relatives à son utilisation dans un commentaire ci-dessus, par exemple:

    /**
     * ^navigation ^lists
     */
    .nav{}

    /**
     * ^grids ^lists ^tables
     */
    .matrix{}

Ces balises permettent à d'autres développeurs de trouver des bouts de code en recherchant une fonction, si un développeur a besoin pour travailler avec des listes ils peuvent rechercher `^lists` et trouver les objets associés `.nav` et `.matrix` (et probablement plus).

#### Association des objets

Lorsque l'on travaille d'une manière orientée objet, vous aurez souvent deux
morceaux de CSS (l'un étant le squelette (l'objet) et l'autre étant la peau
(l'extension)) qui sont très étroitement liés, mais qui vivent dans des endroits
très différents.
Afin d'établir un lien béton entre l'objet et son extension nous utiliserons des
*pointeurs objet / extension*. Ce sont simplement des commentaires comme ceci :

Dans votre feuille de style de base :

    /**
     * Extend `.foo` in theme.css
     */
     .foo{}

Dans votre feuille de style de thème :

    /**
     * Extends `.foo` in base.css
     */
     .bar{}

Ici, nous avons établi une relation concrète entre deux morceaux de code très distincts.

---

## Ecrire du CSS

La section précédente explorait la façon dont nous structurons et formons notre CSS ; ces différentes règles sont très quantifiables. La section suivante est un peu plus théorique et traite d'attitude et d'approche à adopter.

## Construire de nouveaux composants

Lors de la construction d'un nouveau composant, créez votre balisage HTML **avant** votre CSS. Cela signifie que vous pouvez voir visuellement les propriétés CSS qui héritent naturellement et ainsi éviter de ré-appliquer des styles redondants.

En écrivant d'abord vos balises, vous pouvez vous concentrer sur les données, le contenu et la sémantique, puis appliquer uniquement les classes appropriées et votre CSS _en dernier_.

## CSSOO

Je travaille d'une manière CSSOO, je sépare les composants en structure (objets) et peau (extensions). L' **analogie** suivante peut correspondre :

    .room{}

    .room--kitchen{}
    .room--bedroom{}
    .room--bathroom{}

Nous avons plusieurs types de pièces dans une maison, mais elles partagent toutes des caractéristiques semblables ; elles ont toutes un plancher, un plafond, des murs et des portes. Nous pouvons partager cette information dans une classe abstraite `.room{}`. Cependant, nous avons des types de pièces spécifiques qui sont différentes des autres; une cuisine pourrait avoir un sol carrelé et une pièce pourrait avoir des tapis, une salle de bains pourrait ne pas avoir une fenêtre, mais une chambre très probablement un grand nombre, chaque pièce a probablement différents murs colorés.
Le CSS Orienté Objet nous apprend à résumer les styles. Il faut les
répartir dans un objet de base, puis _étendre_ ces informations avec des classes plus spécifiques pour ajouter le traitement unique.

Donc, au lieu de construire des dizaines de composants uniques, essayez de repérer les modèles de conception qui se répètent. Abstractisez-les en classes réutilisables ; construirez ces squelettes comme des «objets» base, puis ajoutez vos classes de style en circonstance pour les rendre uniques.

Si vous avez à construire un nouveau composant, scindez le en structure et en peau ; construisez la structure du composant en utilisant des classes très génériques afin que nous puissions réutiliser ces morceaux et utiliser des classes plus spécifiques pour la peau en y ajoutant un traitement du design.

## Mise en page

Tous les composants que vous créez doivent être laissés totalement libres de largeurs, ils doivent toujours rester fluides et leurs largeurs doivent être régies par un système de parent / de grille.

Les hauteurs ne doivent **jamais** être appliquées aux éléments. Les hauteurs ne devraient être appliquées qu'à des éléments qui avaient des dimensions _avant_ leur intégration sur le site (autrement dit les images et des sprites). Ne jamais mettre de hauteurs sur les balises `p`, `ul`, `div`, ou n'importe quoi d'autre.
Vous pouvez souvent obtenir l'effet désiré avec `line-height` qui est beaucoup plus souple.

Les systèmes de grilles devraient être considérées comme des étagères. Ils contiennent du contenu, mais ne sont pas du contenu eux-mêmes. Vous mettez en place vos étagères puis les remplissez avec vos objets.
En mettant en place nos grilles séparément de nos composants, vous pourrez les déplacer beaucoup plus facilement que s'ils avaient des dimensions associées, ce qui rend notre front-end beaucoup plus souple et rapide à utiliser.

Vous ne devriez jamais appliquer du style à un élément de la grille, ces derniers s'utilisent uniquement pour notre mise en page. Appliquez un style au contenu _à l'intérieur_ d'un élément de grille. Ne jamais, en _aucune_ circonstance, appliquer des propriétés de modèle de boîte (box-model) à un élément de grille.

## Taille des interfaces

J'utilise une combinaison de différentes méthodes pour les gérer les tailles d'interfaces : les pourcentages, les pixels, `ems`, `rems` et aucune propriété.

Les systèmes de grilles devraient, idéalement, être mis en pourcentage. Parce que j'utilise les systèmes de grille pour gouverner la largeur des colonnes et des pages, je peux laisser les objets totalement libres de dimensions (voir ci-dessus).

Les tailles de police en `rems` sont sécurisées avec une taille en pixel.
Cette méthode conserve les avantages de l'accessibilité données par les `em` et fixe une taille en `px` pour les vieux navigateurs. Voici une mixin Sass permettant la mise en oeuvre de ce concept (en supposant que vous définissez votre taille de police de base quelque part) :

    @mixin font-size($font-size){
        font-size:$font-size +px;
        font-size:$font-size / $base-font-size +rem;
    }

J'utilise seulement les pixels pour les objets dont les dimensions sont fixées.
Cela inclut des choses comme les images et les sprites dont les dimensions sont en pixels.

### Taille des polices

Je définis une série de classes qui s'apparentent à un système de grille pour le dimensionnement des polices. Ces classes peuvent être utilisées pour respecter une hiérarchie des styles. Pour une explication complète veuillez vous référer à cet article [Pragmatic, practical font-sizing in CSS](http://csswizardry.com/2012/02/pragmatic-practical-font-sizing-in-css)

## Raccourcis

**Les raccourcis CSS doivent être utilisés avec prudence.**

Il peut être tentant d'utiliser des déclarations comme `background: red;` mais
en faisant cela, ce que vous êtes en train de coder est : « Je ne veux pas d'image de fond qui défile, aligné en haut à gauche, répété en X et Y, avec une couleur de fond de rouge ». Neuf fois sur dix, cela n'entraînera pas de problèmes, mais dans ce cas-là il est justifié de ne pas utiliser de raccourci.
En remplacement, utilisez `background-color: red;`.

De même, les déclarations comme `margin: 0;` sont agréables et courtes, mais **restez explicite**. Si vous voulez réellement n'affecter la marge que sur le bas d'un élément, il est plus approprié d'utiliser `margin-bottom: 0;`.

Soyez explicite dans les propriétés que vous définissez et prenez soin de ne pas, par inadvertance, en écraser d'autres avec un raccourci. Par exemple si vous ne voulez pas supprimer la marge inférieure sur un élément alors il n'y a aucun sens à la mise à zéro toutes les marges avec `margin: 0;`.

Les raccourcis sont une bonne chose mais ils sont trop facilement usurpés.

## IDs

Une note rapide sur les identifiants en CSS avant de nous plonger dans les sélecteurs en général.

**Ne JAMAIS utiliser des ID en CSS.**

Ils peuvent être utilisés dans votre balisage pour de l'identification en JS, mais pour styler vos éléments, utilisez seulement des classes.
Vous ne voulez pas voir un seul identifiant dans tous vos styles !

Les classes ont l'avantage d'être réutilisable (même si nous ne voulons pas, nous pouvons) et ils ont une belle et faible spécificité. La spécificité est l'une des façons les plus rapides de rencontrer des difficultés dans les projets et la maintenir à un faible niveau en tout temps est impératif. Un ID est **255** fois plus précis qu'une classe, donc ne les utilisez _jamais_ en CSS _jamais_.

## Sélecteurs

Gardez les sélecteurs courts, efficaces et portables.

Les sélecteurs basés sur la position sont mauvais pour un certain nombre de raisons.
Par exemple, prenez `.sidebar h3 span{}`. Ce sélecteur est trop basé sur la position et donc ne nous permet pas de déplacer un `span` en dehors d'un `h3` sans casser le style.

Les sélecteurs trop longs introduisent également des problèmes de performance ; plus il y a de niveau dans un sélecteur (par exemple `.sidebar h3 span` a trois niveaux, `.content ul p a` en a quatre), plus le navigateur a de traitements à effectuer.

Assurez-vous que les styles soient indépendants de la position lorsque cela est possible, et assurez-vous qu'ils soient simples et courts.

Les sélecteurs doivent être courts (par exemple, un niveau d'une classe de profondeur) mais les noms de classe eux-mêmes devraient être aussi longs que possible. Une classe `.user-avatar` est bien plus agréable que `.usr-avt`.

**Rappelez-vous :** les classes ne sont ni sémantiques ni non-sémantiques !
Arrêter de stresser sur les noms de classe « sémantique » et choisissez quelque chose de simple à l'épreuve du temps.

### Sur-qualification des sélecteurs

Comme indiqué plus haut, les chaînes de sélecteurs sont de mauvaises nouvelles.

Une sur-qualification des sélecteurs ressemble à `div.promo`. Vous obtiendrez sûrement le même résultat en utilisant simplement `.promo`. Bien sûr, dans certains cas vous _voulez_ associer une classe avec un élément. Exemple : vous avez une classe générique `.error` qui a besoin d'avoir un aspect différent en fonction de son élément (par exemple,
`.error {color: red;}` et `div.error {padding: 14px;}`). Généralement, essayez
d'éviter lorsque cela est possible.

Un autre exemple d'un sélecteur sur-qualifié pourrait être `ul.nav li a {}`. Comme ci-dessus, nous pouvons supprimer `ul` puisque nous savons que `.nav` est une liste, il est aussi logique que `a` _doit_ être dans un `li`, donc nous mettre à la diète `ul.nav li a {}` pour obtenir simplement `.nav a{}`.

### Performance des sélecteurs

S'il est vrai que les navigateurs ne pourront pas continuer à interpréter encore plus rapidement le CSS, l'efficacité est quelque chose que vous pourriez garder en tête. En résumé, évitez les sélecteurs non imbriquées, l'universel (`*{}`), ainsi que les sélecteurs CSS3 plus complexes devraient permettre de contourner ces problèmes.

## L'intention de sélection

Au lieu d'utiliser les sélecteurs pour cibler un élément du DOM, il est souvent
préférable de mettre une classe sur l'élément que vous voulez explicitement styler.
Prenons l'exemple précis d'un sélecteur comme `.header ul{}` ...

Imaginons que `ul` est en effet le menu principal de notre site Web. il vit dans
l'en-tête et vous pensez que se sera le seul `ul` en ces lieux ; `.header ul{}` fonctionnera, mais ce n'est pas idéal ou souhaitable.
Ce n'est pas à l'épreuve du temps et certainement pas assez explicite. Dès que nous ajouterons un autre `ul` pour cet en-tête il va adopter le style de notre navigation principale.
Il y a beaucoup de chances que ce ne soit pas voulu. Cela signifie que nous devons soit remanier une grande quantité de code _ou_ annuler beaucoup de styles sur les `ul`s dans ce `.header` pour supprimer les effets de la sélection globale.

L'intention de votre sélecteur doit correspondre à la raison de votre style ;
demandez-vous **'Est-ce-que je sélectionne cela car c'est un `ul` à l'intérieur
de `.header` ou parce que c'est la navigation principale de mon site ?'**.
La réponse à cette question permettra de déterminer votre sélecteur.

Assurez-vous que votre sélecteur clé n'est jamais un élément / type ou
une classe abstraite. Vous ne voulez pas vraiment voir comme sélecteurs
`.sidebar ul{}` ou `.footer .media{}` dans votre feuille de thème.

Soyez explicites ; ciblez l'élément que vous voulez modifier, pas son parent. Ne supposez jamais que le balisage ne changera pas. **Codez des sélecteurs qui ciblent ce que vous voulez, pas ce qui se trouve être déjà là.**

Vous pouvez consulter un article complet sur la question
[Shoot to kill; CSS selector intent](http://csswizardry.com/2012/07/shoot-to-kill-css-selector-intent/).

## `!important`

Il est correct d'utiliser `!important` sur des classes d'assistance uniquement.
Vous pouvez aussi faire de la prévention en ajoutant `!important` dans le cas où vous savez que la règle sera **toujours ** prioritaire, par exemple `.error {color: red !important;}`.

Utiliser `!important` pour sortir d'une situation périlleuse n'est pas conseillé. Retravaillez votre CSS et essayez de lutter contre ces problèmes en
[réusinant](http://fr.wikipedia.org/wiki/R%C3%A9usinage_de_code) vos sélecteurs. Garder vos sélecteurs courts en évitant les IDS vous aidera énormément.

## Nombres magiques et absolus

Un nombre magique est un nombre qui est utilisé parce que « ça fonctionne ». Ceux-ci sont mauvais parce qu'ils travaillent rarement pour un motif réel et ne sont généralement pas à l'épreuve du temps ou flexible. Ils ont tendance à fixer des symptômes et non des problèmes.

Par exemple, utiliser `.dropdown-nav li:hover ul{ top:37px; }` pour déplacer une liste déroulante avec `:hover` est mauvais, puisque 37px est un nombre magique. 37px fonctionne seulement grâce à un coup de chance puisque `.dropdown-nav` a justement 37px de hauteur.

Au lieu de cela, vous devez utiliser `.dropdown-nav li:hover ul{ top:100%; }`.
quelque soit la hauteur de `.dropdown-nav`, dans la liste déroulante aura toujours 100% de déplacement par rapport à la hauteur.

Chaque fois que vous codez en dur un certain nombre, réfléchissez-y à deux fois, si vous pouvez l'éviter en utilisant de mots-clés ou «alias» (`top: 100%` signifie «tout le chemin depuis le sommet») ou &mdash;encore mieux&mdash; pas de mesure du tout, alors vous devriez probablement y arriver.

Chaque mesure codée en dur que vous définissez est un engagement que vous ne pourriez pas nécessairement vouloir conserver.

## Styles conditionnels

Les feuilles de style IE peuvent, généralement, être totalement évitées. La seule fois où une feuille de style IE peut être nécessaire est de contourner le manque flagrant de fonctionnalités (une correction des PNG par exemple).

En règle générale, toutes les règles de mise en page et le modèle de boîte _devraient_ fonctionner sans feuille de style IE si vous réusinez et retravaillez votre CSS. Cela signifie que vous ne rencontrerez plus jamais `<!--[if IE 7]> element{ margin-left:-9px; } < ![endif]-->` ou un autre
CSS clairement utilisé de façon arbitraire simplement « parce que ça fonctionne ».

## Débugage

Si vous rencontrez un problème CSS **relisez le code avant de commencer à en ajouter encore plus** dans l'espoir de le corriger. Le problème existe en CSS et il est déjà écrit, ajouter plus de CSS n'est pas la bonne réponse !

Supprimez vos balises HTML et votre CSS jusqu'à ce que votre problème disparaisse, ensuite vous pouvez déterminer quelle partie du code pose problème.

Il peut être tentant de mettre `overflow: hidden;` pour cacher les effets d'une bizarrerie de mise en page, mais `overflow` n'a probablement jamais été le problème ; **fixez le problème, et non ses symptômes.**

## Pré-processeurs

Sass est mon pré-processeur de choix. **Utilisez-le à bon escient.** Utiliser Sass pour rendre votre CSS plus puissant, mais évitez la spécification comme la peste !
Spécifiez seulement si c'est réellement nécessaire à votre CSS, par exemple

    .header{}
    .header .site-nav{}
    .header .site-nav li{}
    .header .site-nav li a{}

Serait tout à fait inutile dans des conditions normales CSS, le SASS est **mauvais** :

    .header{
        .site-nav{
            li{
                a{}
            }
        }
    }

Si vous deviez mettre SASS en place vous coderiez :

    .header{}
    .site-nav{
        li{}
        a{}
    }
