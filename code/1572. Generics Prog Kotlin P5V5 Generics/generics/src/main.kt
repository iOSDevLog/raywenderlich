/**
 *
 */
interface Repository<T> {
    fun addItem(item:T)
    fun deleteItem(item:T)
}
class Person(val name : String)
class PersonRepository : Repository<Person> {
    override fun addItem(item: Person) {
    }

    override fun deleteItem(item: Person) {
    }
}

fun <T> printItem(item : T) {
    println(item)
}

fun <MyItem> printMyItem(item : MyItem) {
}

fun main(args: Array<String>) {
    val names = ArrayList<String>()
    val myNumbers = ArrayList<Number>()
    myNumbers.add(1)
    myNumbers.add(2.5)

    printItem("Test")

}