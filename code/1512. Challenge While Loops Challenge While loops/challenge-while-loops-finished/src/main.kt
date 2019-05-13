/**
 *
 */
import java.util.*

/**
 *
 */
fun main(args: Array<String>) {
/*
 ### WHILE LOOPS
 Create a variable named `counter` and set it equal to 0. Create a `while` loop with
 the condition `counter < 10` which prints out `counter` is `X`
 (where `X` is replaced with counter value) and then increments `counter` by 1.
 */

    var counter = 0
    while (counter < 10) {
        println("counter is $counter")
        counter += 1
    }


/*
 Create a variable named count and set it equal to 0.
 Create another variable named roll and set it equal to 0.
 Create another variable named random and set it equal to Random().
 Create a do-while loop. Inside the loop, set roll equal to random.nextInt(6)
 which means to pick a random number between 0 and 5. Then increment counter by 1.
 Finally, print 'After X rolls, roll is Y' where X is the value of
 count and Y is the value of roll. Set the loop condition such that the
 loop finishes when the first 0 is rolled.
 */


    var count = 0
    var roll = 0
    val random = Random()
    do {
        roll = random.nextInt(6)
        count += 1
        println("After $count roll(s), roll is $roll")
    } while (roll != 0)
}
