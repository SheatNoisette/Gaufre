# Gaufre programming language
Here is another simple esoteric language.

# Instructions

`#: Quitter`
`## : Incrémenter la cellule de mémoire active X fois (1 argument)`
`### : Décrémenter la cellule mémoire active X fois (1 argument)`
`#### : Déplacer le curseur mémoire vers la gauche de X fois (1 argument)`
`##### : Déplacer le curseur mémoire vers la droite de X fois (1 agument)`
`###### : Aller à la ligne X (1 Argument)`
`####### : A==B ? Goto X (3 arguments: A - B - X )`
`######## : Afficher un char (1 argument)`
`######### : Prendre un caractère de la console et le placer dans la cellule mémoire active (conversion char -> Id table ASCII)`

If there no argument provided, Gaufre will use the value of the current selected cell instead.