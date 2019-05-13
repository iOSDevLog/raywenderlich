/**
 *
 */
fun main(args: Array<String>) {
//    while (/*condition*/) {
//        //LOOP CODE
//    }

    var i = 1
    while (i < 10) {
        print(i)
        i += 1
    }
    println("- - -")

//    do {
//        <LOOP CODE>
//    } while (<CONDITION>)

    i = 1
    do {
        print(i)
        i += 1
    } while (i < 10)
    println("- - -")

    i = 1
    do {
        print(i)
        if (i == 5) {
            break
        }
        i += 1
    } while (i < 10)
    println("After do")
}