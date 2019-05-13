/**
 *
 */
fun main(args: Array<String>) {
    val names = listOf("Anna", "Brian", "Craig", "Donna")
    println(names)

    val teamNames = mutableListOf<String>()
    teamNames.addAll(names)
    teamNames.add("Sam")
    teamNames.add("Jan")

    println(names[0])
    println(names.indexOf("Brian"))

    teamNames.remove("Craig")
    println(teamNames)

    for (name in teamNames) {
        println("Team Member : $name")
    }
}