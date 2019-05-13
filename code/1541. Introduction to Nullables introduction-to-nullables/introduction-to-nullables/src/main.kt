/**
 *
 */
fun main(args: Array<String>) {
    fun printNickname(nickname: String?) {
        println("My Nickname is $nickname")
    }
    var nickname: String? = null

    printNickname(nickname)
    nickname = "Kev"
    printNickname(nickname)

}