enum TokenType {
    num, //number
    id, //identifier
    temp, //temporary variable
    none //none
};
typedef struct {
    enum TokenType type;
    int val;
    // num -numeric value
    // id -symbol table index
    // temp -temporay symbol table index
} Token;