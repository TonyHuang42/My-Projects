#!/usr/bin/python3
# CMPT310 A2
#####################################################
#####################################################
# Please enter the number of hours you spent on this
# assignment here
"""
num_hours_i_spent_on_this_assignment = 
"""
#
#####################################################
#####################################################

#####################################################
#####################################################
# Give one short piece of feedback about the course so far. What
# have you found most interesting? Is there a topic that you had trouble
# understanding? Are there any changes that could improve the value of the
# course to you? (We will anonymize these before reading them.)
"""
<Your feedback goes here>


"""
#####################################################
#####################################################
import sys, getopt
import copy
import random
import time
import numpy as np
sys.setrecursionlimit(10000)

class SatInstance:
    def __init__(self):
        pass

    def from_file(self, inputfile):
        self.clauses = list()
        self.VARS = set()
        self.p = 0
        self.cnf = 0
        with open(inputfile, "r") as input_file:
            self.clauses.append(list())
            maxvar = 0
            for line in input_file:
                tokens = line.split()
                if len(tokens) != 0 and tokens[0] not in ("p", "c"):
                    for tok in tokens:
                        lit = int(tok)
                        maxvar = max(maxvar, abs(lit))
                        if lit == 0:
                            self.clauses.append(list())
                        else:
                            self.clauses[-1].append(lit)
                if tokens[0] == "p":
                    self.p = int(tokens[2])
                    self.cnf = int(tokens[3])
            assert len(self.clauses[-1]) == 0
            self.clauses.pop()
            if (maxvar > self.p):
                print("Non-standard CNF encoding!")
                sys.exit(5)
        # Variables are numbered from 1 to p
        for i in range(1, self.p + 1):
            self.VARS.add(i)

    def __str__(self):
        s = ""
        for clause in self.clauses:
            s += str(clause)
            s += "\n"
        return s


def main(argv):
    inputfile = ''
    verbosity = False
    inputflag = False
    try:
        opts, args = getopt.getopt(argv, "hi:v", ["ifile="])
    except getopt.GetoptError:
        print('DPLLsat.py -i <inputCNFfile> [-v] ')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print('DPLLsat.py -i <inputCNFfile> [-v]')
            sys.exit()
        ##-v sets the verbosity of informational output
        ## (set to true for output veriable assignments, defaults to false)
        elif opt == '-v':
            verbosity = True
        elif opt in ("-i", "--ifile"):
            inputfile = arg
            inputflag = True
    if inputflag:
        instance = SatInstance()
        instance.from_file(inputfile)
        #start_time = time.time()
        solve_dpll(instance, verbosity)
        #print("--- %s seconds ---" % (time.time() - start_time))

    else:
        print("You must have an input file!")
        print('DPLLsat.py -i <inputCNFfile> [-v]')


# Finds a satisfying assignment to a SAT instance,
# using the DPLL algorithm.
# Input: a SAT instance and verbosity flag
# Output: print "UNSAT" or
#    "SAT"
#    list of true literals (if verbosity == True)
#
#  You will need to define your own
#  DPLLsat(), DPLL(), pure-elim(), propagate-units(), and
#  any other auxiliary functions
def solve_dpll(instance, verbosity):
    # print(instance)
    # instance.VARS goes 1 to N in a dict
    # print(instance.VARS)
    # print(verbosity)
    ###########################################
    # Start your code
    clauses = instance.clauses
    variables = instance.VARS

    result = DPLL(clauses, variables)
    if not result:
        print("UNSAT")
    else:
        print("SAT")
        if verbosity:
            true_literals = []
            for i in result:
                if result[i] == True:
                    true_literals.append(i)
            true_literals.sort()
            print(true_literals)


def DPLLsat(clauses, model):
    for literal in model:
        if model[literal] == True:
            symbol = literal
        else:
            symbol = -literal

        i = 0
        while i != len(clauses):
            if symbol in clauses[i]:
                clauses.pop(i)
            else:
                i += 1

        for clause in clauses:
            if -symbol in clause:
                clause.remove(-symbol)

    if len(clauses) == 0:
        return 1
    if ([] in clauses):
        return 0
    return -1


def propagate_units(clauses, symbols, model):
    unit = False
    unit_clauses = []
    for clause in clauses:
        if len(clause) == 1:
            unit = True
            unit_clauses.append(clause[0])
    if unit == True:
        for unit_clause in unit_clauses:
            for clause in clauses:
                if -unit_clause in clause:
                    clause.remove(-unit_clause)
            
            if unit_clause > 0:
                model[abs(unit_clause)] = True
            
            else:
                model[abs(unit_clause)] = False
            
            if abs(unit_clause) in symbols:
                symbols.remove(abs(unit_clause))
        return True
    else:
        return False


def pure_elim(clauses, symbols, model):
    pure = False
    pure_literals = []
    true_list = []
    false_list = []
    for symbol in symbols:
        for clause in clauses:
            if symbol in clause and symbol not in true_list:
                true_list.append(symbol)

            if -symbol in clause and -symbol not in false_list:
                false_list.append(symbol)
        
    for i in true_list:
        if i not in false_list:
            model[i] = True
            if i in symbols:
                symbols.remove(i)
            pure = True

    for i in false_list:
        if i not in true_list:
            model[i] = False
            if i in symbols:
                symbols.remove(i)
            pure = True

    return pure


def DPLL(original_clauses, original_symbols, original_model={}):
    clauses = copy.deepcopy(original_clauses)
    symbols = copy.deepcopy(original_symbols)
    model = copy.deepcopy(original_model)

    result = DPLLsat(clauses, model)
    if result == 1:
        return model
    if result == 0:
        return False

    if pure_elim(clauses, symbols, model):
        return DPLL(clauses, symbols, model)

    if propagate_units(clauses, symbols, model):
        return DPLL(clauses, symbols, model)

    symbol_count = {}
    for symbol in symbols:
        symbol_count[symbol] = 0
        for clause in clauses:
            if symbol in clause:
                symbol_count[symbol] += 1
    P = max(symbol_count, key = symbol_count.get)
    symbols.remove(P)

    for value in [True, False]:
        model[P] = value
        ret = DPLL(clauses, symbols, model)
        if ret is not False and ret is not None:
            return ret

    ###########################################


if __name__ == "__main__":
    main(sys.argv[1:])
