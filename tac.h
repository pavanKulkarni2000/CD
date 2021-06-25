#ifndef TAC_H
#define TAC_H

enum OperandType{
    id, num, temp, none
};

struct Operand{
    enum OperandType type;
    int val;
};

struct TacInstr{
    struct Operand lhs,opd1,opd2;
    char opr;
};

#endif //TAC_H