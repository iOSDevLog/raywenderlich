/**
 *
 */
enum class Direction  {
    NORTH, SOUTH, WEST, EAST;
    fun printDirection() {
        println("Direction $this")
    }
}

enum class Color(val r:Int, g:Int, b:Int) {
    RED(255, 0,0),
    YELLOW(255, 255,0),
    GREEN(0, 255,0),
}

fun main(args: Array<String>) {
    fun drive(direction: Direction) {
        when(direction) {
            Direction.NORTH -> println("Driving North")
            Direction.SOUTH -> println("Driving South")
            Direction.WEST -> println("Driving West")
            Direction.EAST -> println("Driving East")
        }
    }

    drive(Direction.NORTH)
    drive(Direction.WEST)
    val direction = Direction.valueOf("NORTH")
    val position = Direction.NORTH.ordinal
    println("Direction $direction")
    println("Position $position")
    Direction.WEST.printDirection()

}