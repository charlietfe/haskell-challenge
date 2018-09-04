# Haskell 30 Days Challenge

## Objective

During 30 days I'll take a challenge of learning Haskell and focusing on nothing else but Haskell (my next stop will be Serverless Architectures). In order to reach the goal and force me to do it, I'm going to write each day what I've learned that day.

## Disclaimer

I know the basics concepts of the language such as, data types, type classes, currying, lazy loading, high order functions, basic functional programming patterns and so on. But I need some deeper knowledge to get the whole thing and be productive as soon as possible with projects at [Theam](https://github.com/theam). So probably my journey could not be followed as a tutorial for learning Haskell.

## Material used to learn

I'm using [Get Programming in Haskell by Will Kurt](https://www.amazon.com/Get-Programming-Haskell-Will-Kurt) because is fairly new and is a short book if you compare with other Haskell books out there.Besides every unit finishes with a nice capstone project to practice the concepts.

*Note:* I will update the materials if I find something interesting along the way.

### Day 1 - Functors

Today I learnt the first type class to work with types in a context. In this case it was the `Functor` type class.

A Functor is a type class that only needs one definition: 

`fmap :: Functor f => (a -> b) -> fa -> fb`

- We could use `<$>` instead as an infix function
- `f` in the functor definition is not a function is refrerring to a functor type itself
    it could be `List`, `Maybe` or whatever.

**Some comments:**

I created some examples here [day-1](https://github.com/charlietfe/haskell-challenge/tree/master/examples/day1).

When you work with a type inside a context any transformation you need to perform should *respect the context* and apply the transformation to the elements inside of it.

The most obvious Functor types are Lists and Maybe types.

- Regarding Lists you can apply a `map` function alongside with transformation to each element of a List to get a new List with the elements transformed:

```
    allPartsHtml' :: [Html]
    allPartsHtml' = map renderHtml allParts
```

- The `Maybe` type is well known to handle the absence of a value and can hold any type inside of it like `Int, Double or RobotPart`.

Intuition tells you that if you have a `Maybe` type, the result after a transformation should also be wrapped inside a `Maybe` as well. Like this:

```

getPartById :: Int -> Maybe RobotPart
getPartById id = Map.lookup id partsDB -- Find the RobotPart inside our DB Map 

{-- 
    Transform a Maybe RobotPart into a Maybe Html
    The important part here is that the result will be wrapped also in a Maybe
    even if renderHtml returns Html and not a Maybe Html
--}

partHtml :: Int -> Maybe Html
partHtml partId = renderHtml <$> getPartById partId

```
