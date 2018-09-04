{--
    Module      : Html
    Description : Small module to output some Html tags
--}
module Html where

type Html = String
type Content = String

data HeaderLevel = H1 | H2 | H3 | H4

p :: String -> Html
p text = "<p>" ++  text ++ "</p>"

header :: HeaderLevel -> Content -> Html
header H1 text = "<h1>" ++  text ++ "</h1>"
header H2 text = "<h2>" ++  text ++ "</h2>"
header H3 text = "<h3>" ++  text ++ "</h3>"
header H4 text = "<h4>" ++  text ++ "</h4>"
 