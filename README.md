
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
