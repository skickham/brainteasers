##global.R
#Data prep

#convert matirx to df
state_stat = data.frame(state.name = rownames(state.x77),
                        state.x77)
#remove row names
rownames(state_stat) = NULL

#create var with colnames as choice
choice = colnames(state_stat)[-1]
