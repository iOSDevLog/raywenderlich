/**
 *
 */
interface Animal {
    val numLegs : Int
    fun eat()
}
class Dog : Animal {
    override val numLegs = 4
    override fun eat() {
        println("Dog eating loudly")
    }
    fun bark() {
        println("Bark, Bark")
    }
}
class Cat : Animal {
    override val numLegs = 4
    override fun eat() {
        println("Cat eating softly")
    }
    fun meow() {
        println("Meow, Meow")
    }
}

fun main(args: Array<String>) {
    val dog = Dog()
    val cat = Cat()

    dog.eat()
    dog.bark()
    cat.eat()
    cat.meow()
}