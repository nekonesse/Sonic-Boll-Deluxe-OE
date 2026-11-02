//give other 10 coins

repeat (100) give_item(argument[0],"coin")
stats("coins collected",stats("coins collected")+100)
