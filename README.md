# MultiDirectionFlowLayout
A flow layout that allows you to scroll in multiple directions

## Usage :-

First of all this collection view layout is designed to keep the first column and the first row pinned , moreover the rows 
after below the first will scroll below the first one.Check the gif below for more info.

![alt text](https://github.com/iThink32/MultiDirectionFlowLayout/blob/master/MultiDirectionFlowlayout.gif)

Anyway if your fine with this flow then to integrate this follow these steps :

1) copy the flow layout from this project to yours
2) Assign the flow layout to your collectionview in your storyboard
3) There are some IBInspectable properties that you have to set :

```
cellHeight - this will be the same for all cells
columnWidth - this will be the width of all the cells of the first column
rowWidth - this will be the width of all the cells except the first cell of each column
```

That's it your good to go , im assuming you have the normal data source and delegate methods set up. 

