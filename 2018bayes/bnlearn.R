source("https://bioconductor.org/biocLite.R")
biocLite("Rgraphviz")
install.packages('bnlearn')

library(bnlearn)
cptA = matrix(c(0.4, 0.6), ncol = 2, dimnames = list(NULL, c("LOW", "HIGH")))
cptB = matrix(c(0.8, 0.2), ncol = 2, dimnames = list(NULL, c("GOOD", "BAD")))
cptC = c(0.5, 0.5, 0.4, 0.6, 0.3, 0.7, 0.2, 0.8)
dim(cptC) = c(2, 2, 2)
dimnames(cptC) = list("C" = c("TRUE", "FALSE"), "A" =  c("LOW", "HIGH"), "B" = c("GOOD", "BAD"))

net = model2network("[A][B][C|A:B]")
dfit = custom.fit(net, dist = list(A = cptA, B = cptB, C = cptC))
dfit
cpquery(dfit, (A == 'HIGH'), (C == 'TRUE'))

cptA = matrix(c(0.4, 0.6), ncol = 2, dimnames = list(NULL, c("LOW", "HIGH")))
cptC = c(0.5, 0.5, 0.4, 0.6)
dim(cptC) = c(2, 2)
dimnames(cptC) = list("C" = c("TRUE", "FALSE"), "A" =  c("LOW", "HIGH"))
net = model2network("[A][C|A]")
dfit = custom.fit(net, dist = list(A = cptA, C = cptC))
dfit
cpquery(dfit, (A == 'HIGH'), (C == 'TRUE'))
cpquery(dfit, (C == 'TRUE'), (A == 'HIGH'))

cptB = matrix(c(0.99, 0.01), ncol = 2, dimnames = list(NULL, c(0, 1)))
cptE = matrix(c(0.98, 0.02), ncol = 2, dimnames = list(NULL, c(0, 1)))
cptA = c(0.92, 0.08, 0.06, 0.94, 0.74, 0.26, 0.05, 0.95)
dim(cptA) = c(2, 2, 2)
dimnames(cptA) = list("A" = c(0, 1),
                      "B" = c(0, 1),
                      "E" = c(0, 1))
cptA
cptS = c(0.9, 0.1, 0.3, 0.7)
dim(cptS) = c(2,2)
dimnames(cptS) = list("S" = c(0, 1),
                      "A" = c(0, 1))
net = model2network("[B][E][A|B:E][S|A]")
dfit = custom.fit(net, dist = list(B = cptB,
                                   E = cptE,
                                   A = cptA,
                                   S = cptS))
dfit
?cpquery
cpquery(dfit, event = (B == 1), evidence = (A == 1), n = 10000000)
cpquery(dfit, (B == 1), (S == 1))
