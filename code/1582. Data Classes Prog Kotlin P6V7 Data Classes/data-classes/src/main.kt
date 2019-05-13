/**
 *
 */
fun main(args: Array<String>) {
    data class Podcast(val title: String,
                       val description: String,
                       val url: String)

    val podcast = Podcast("Android Central", "The premier source for weekly news", "http://feeds.feedburner.com/AndroidCentralPodcast")

    val podcast2 = podcast.copy(title = "Android Central Podcast")
    val (title, description, url) = podcast2
    println("title = $title, url = $url")
}