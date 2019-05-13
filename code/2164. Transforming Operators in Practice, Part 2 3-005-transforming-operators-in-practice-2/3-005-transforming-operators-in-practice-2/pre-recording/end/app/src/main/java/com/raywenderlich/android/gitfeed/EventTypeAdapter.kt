package com.raywenderlich.android.gitfeed

import com.google.gson.TypeAdapter
import com.google.gson.stream.JsonReader
import com.google.gson.stream.JsonWriter
import java.io.IOException

private const val REPO = "repo"
private const val NAME = "name"
private const val IMAGE_URL = "imageUrl"
private const val ACTION = "action"

class EventTypeAdapter : TypeAdapter<Event>() {
  @Throws(IOException::class)
  override fun write(out: JsonWriter, event: Event) {
    out.beginObject()
    out.name(REPO).value(event.repo)
    out.name(NAME).value(event.name)
    out.name(IMAGE_URL).value(event.imageUrl)
    out.name(ACTION).value(event.action)
    out.endObject()
  }

  @Throws(IOException::class)
  override fun read(reader: JsonReader): Event {
    var repo = ""
    var name = ""
    var imageUrl = ""
    var action = ""

    reader.beginObject()
    while (reader.hasNext()) {
      when (reader.nextName()) {
        REPO -> repo = reader.nextString()
        NAME -> name = reader.nextString()
        IMAGE_URL -> imageUrl = reader.nextString()
        ACTION -> action = reader.nextString()
      }
    }
    reader.endObject()

    return Event(repo, name, imageUrl, action)
  }
}