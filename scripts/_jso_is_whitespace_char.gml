{
    /**
    _jso_is_whitespace_char(char): Return whether <char> is a whitespace character.
    Definition of whitespace is given by Unicode 6.0, Chapter 4.6.
    */
    switch (ord(argument0)) {
        case $0009:
        case $000A:
        case $000B:
        case $000C:
        case $000D:
        case $0020:
        case $0085:
        case $00A0:
        case $1680:
        case $180E:
        case $2000:
        case $2001:
        case $2002:
        case $2003:
        case $2004:
        case $2005:
        case $2006:
        case $2007:
        case $2008:
        case $2009:
        case $200A:
        case $2028:
        case $2029:
        case $202F:
        case $205F:
        case $3000:
            return true;
    }
    return false;
}
