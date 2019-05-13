package com.raywenderlich.android.creatures.remote

import com.google.gson.FieldNamingPolicy
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit


/**
 * Provide "make" methods to create instances of [CreatureService]
 * and its related dependencies, such as OkHttpClient, Gson, etc.
 */
object CreatureServiceFactory {

  fun makeCreatureService(isDebug: Boolean): CreatureService {
    val okHttpClient = makeOkHttpClient(
        makeLoggingInterceptor(isDebug))
    return makeCreatureService(okHttpClient, makeGson())
  }

  private fun makeCreatureService(okHttpClient: OkHttpClient, gson: Gson): CreatureService {
    val retrofit = Retrofit.Builder()
        .baseUrl("https://s3.amazonaws.com/rwcreatures/")
        .client(okHttpClient)
        .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
        .addConverterFactory(GsonConverterFactory.create(gson))
        .build()
    return retrofit.create(CreatureService::class.java)
  }

  private fun makeOkHttpClient(httpLoggingInterceptor: HttpLoggingInterceptor): OkHttpClient {
    return OkHttpClient.Builder()
        .addInterceptor(httpLoggingInterceptor)
        .connectTimeout(120, TimeUnit.SECONDS)
        .readTimeout(120, TimeUnit.SECONDS)
        .build()
  }

  private fun makeGson(): Gson {
    return GsonBuilder()
        .setLenient()
        .setDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        .create()
  }

  private fun makeLoggingInterceptor(isDebug: Boolean): HttpLoggingInterceptor {
    val logging = HttpLoggingInterceptor()
    logging.level = if (isDebug)
      HttpLoggingInterceptor.Level.BODY
    else
      HttpLoggingInterceptor.Level.NONE
    return logging
  }

}