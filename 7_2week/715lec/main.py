import numpy as np
from time import time
import pickle
from perceptron import Perceptron

def step1_learning():
    ppn= Perceptron(eta=0.1)
    print(ppn.eta)

def step2_using():
    pass

step1_learning()
step2_using()