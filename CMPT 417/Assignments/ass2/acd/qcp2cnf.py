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


def property_a(order):
    result = np.zeros((order*order, order+1)).astype(int)
    line = 0
    for i in range(order):
        for j in range(order):
            for k in range(order):
                result[line][k] = (i+1)*10000 + (j+1)*100 + (k+1)
            line += 1
    return result


def property_c(order):
    result = np.zeros((round(order*order*order*(order-1)/2), 3)).astype(int)
    line = 0
    for i in range(order-1):
        for j in range(order):
            for k in range(order):
                for l in range(i+1, order):
                    result[line][0] = -((k+1)*10000 + (i+1)*100 + (j+1))
                    result[line][1] = -((k+1)*10000 + (l+1)*100 + (j+1))
                    line += 1
    return result


def property_d(order):
    result = np.zeros((round(order*order*order*(order-1)/2), 3)).astype(int)
    line = 0
    for i in range(order-1):
        for j in range(order):
            for k in range(order):
                for l in range(i+1, order):
                    result[line][0] = -((i+1)*10000 + (k+1)*100 + (j+1))
                    result[line][1] = -((l+1)*10000 + (k+1)*100 + (j+1))
                    line += 1
    return result


def write(clauses, prop_a, prop_c, prop_d, order, filename):
    file = open(os.path.join("./output", filename), "w+")
    file.write("p cnf " + str(order*order*order*2) + " " + str(len(clauses)+len(prop_a)+len(prop_c)+len(prop_d)) + "\n")
    for line in clauses:
        file.write(str(line[0]) + " " + str(line[1]) + "\n")
    for line in prop_a:
        for item in line:
            if item != 0:
                file.write(str(item) + " ")
            else:
                file.write(str(item) + "\n")
    for line in prop_c:
        for item in line:
            if item != 0:
                file.write(str(item) + " ")
            else:
                file.write(str(item) + "\n")
    for line in prop_d:
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
    write(qcp2clauses(qcp, order), property_a(order), property_c(order), property_d(order), order, output_file)


#all QCPs
if sys.argv[1] == "all":
    instance_order = [10, 16, 20, 24, 30, 32, 49]
    for i in range(7):
        for j in range(4):
            input_file = "q_" + str(instance_order[i]) + "_0" + str(j+1) + ".qcp"
            output_file = "q_" + str(instance_order[i]) + "_0" + str(j+1) + ".cnf"
            qcp, order = load(input_file)
            write(qcp2clauses(qcp, order), property_a(order), property_c(order), property_d(order), order, output_file)