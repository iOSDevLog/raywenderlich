sealed class Droid : Throwable() {
  class OU812 : Droid()
}

sealed class FileReadError : Throwable() {
  class FileNotFound : FileReadError()
}

fun main(args: Array<String>) {

}