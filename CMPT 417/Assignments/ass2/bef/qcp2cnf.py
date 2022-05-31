import os
import sys
import numpy as np

def load(filename):
    file = open(os.path.join("./A2-qcp-instances", filename), "r")
    first_line = file.readline()
    order = int(first_line[6] + first_line[7])
    qcp = np.zeros((order, order)).astype(int)
    for i in range(order):
        line = file.readline()
        index = 0
        j = 0
        while j < len(line):
            if line[j].isdigit() and line[j+1].isdigit():
                qcp[i][index] = int(line[j] + line[j+1])
                index += 1
                j +=  1
                
            elif line[j].isdigit():
                qcp[i][index] = int(line[j])
                index += 1

            elif line[j] == '.':
                qcp[i][index] = 0
                index += 1
            j += 1
    file.close()
    return qcp, order


def qcp2clauses(qcp, order):
    result = np.zeros((np.count_nonzero(qcp),2)).astype(int)
    line = 0
    for i in range(order):
        for j in range(order):
            if qcp[i][j] != 0:
                result[line][0] = (i+1)*10000 + (j+1)*100 + qcp[i][j]
                line += 1
    return result


def property_b(order):
    result = np.zeros((round(order*order*order*(order-1)/2), 3)).astype(int)
    line = 0
    for i in range(order):
        for j in range(order):
            for k in range(order-1):
                for l in range(k+1, order):
                    result[line][0] = -((i+1)*10000 + (j+1)*100 + (k+1))
                    result[line][1] = -((i+1)*10000 + (j+1)*100 + (l+1))
                    line += 1
    return result


def property_e(order):
    result = np.zeros((order*order, order+1)).astype(int)
    line = 0
    for i in range(order):
        for j in range(order):
            for k in range(order):
                result[line][k] = (i+1)*10000 + (k+1)*100 + (j+1)
            line += 1
    return result


def property_f(order):
    result = np.zeros((order*order, order+1)).astype(int)
    line = 0
    for i in range(order):
        for j in range(order):
            for k in range(order):
                result[line][k] = (k+1)*10000 + (i+1)*100 + (j+1)
            line += 1
    return result  


def write(clauses, prop_b, prop_e, prop_f, order, filename):
    file = open(os.path.join("./output", filename), "w+")
    file.write("p cnf " + str(order*order*order*2) + " " + str(len(clauses)+len(prop_b)+len(prop_e)+len(prop_f)) + "\n")
    for line in clauses:
        file.write(str(line[0]) + " " + str(line[1]) + "\n")
    for line in prop_b:
        for item in line:
            if item != 0:
                file.write(str(item) + " ")
            else:
                file.write(str(item) + "\n")
    for line in prop_e:
        for item in line:
            if item != 0:
                file.write(str(item) + " ")
            else:
                file.write(str(item) + "\n")
    for line in prop_f:
        for item in line:
            if item != 0:
                file.write(str(item) + " ")
            else:
                file.write(str(item) + "\n")  
    file.close()

#single QCP
if sys.argv[1] != "all":
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    qcp, order = load(input_file)
    write(qcp2clauses(qcp, order), property_b(order), property_e(order), property_f(order), order, output_file)


#all QCPs
if sys.argv[1] == "all":
    instance_order = [10, 16, 20, 24, 30, 32, 49]
    for i in range(7):
        for j in range(4):
            input_file = "q_" + str(instance_order[i]) + "_0" + str(j+1) + ".qcp"
            output_file = "q_" + str(instance_order[i]) + "_0" + str(j+1) + ".cnf"
            qcp, order = load(input_file)
            write(qcp2clauses(qcp, order), property_b(order), property_e(order), property_f(order), order, output_file)