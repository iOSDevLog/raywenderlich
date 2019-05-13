/**
 * Create an enum called Animals and add the following types:
 * CAT, DOG, RAT, BIRD, HAMSTER
 */
enum class Animals  {
    CAT, DOG, RAT, BIRD, HAMSTER;

    fun printDirection() {
        println("Direction $this")
    }
}

/**
 * Create another enum called Cage and add the following:
 * SMALL, MEDIUM, LARGE
 */
enum class Cage {
    SMALL, MEDIUM, LARGE
}

/**
 * Write a function named addAnimalToCage that takes a animal and Cage and print
 * out the animal and the cage that it will be in
 */
fun addAnimalToCage(animal: Animals, cage: Cage) {
    println("The $animal is in the $cage cage")
}



/**
 * Call addAnimalToCage multiple times with different animals and cages
 * Try to use the appropriate cage size for the animal
 */
fun main(args: Array<String>) {
    addAnimalToCage(Animals.BIRD, Cage.SMALL)
    addAnimalToCage(Animals.CAT, Cage.MEDIUM)
    addAnimalToCage(Animals.DOG, Cage.LARGE)
    addAnimalToCage(Animals.HAMSTER, Cage.SMALL)
}
