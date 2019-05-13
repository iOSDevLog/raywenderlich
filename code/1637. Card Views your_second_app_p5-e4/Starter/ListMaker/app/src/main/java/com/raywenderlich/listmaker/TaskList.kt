package com.raywenderlich.listmaker

import android.os.Parcel
import android.os.Parcelable

/**
 * Created by Brian on 2/22/18.
 */
class TaskList(val name: String, val tasks: ArrayList<String> = ArrayList<String>()) : Parcelable {

    constructor(source: Parcel) : this (source.readString(), source.createStringArrayList())

    override fun describeContents(): Int = 0

    override fun writeToParcel(dest: Parcel, flags: Int) {
        dest.writeString(name)
        dest.writeStringList(tasks)
    }

    companion object CREATOR: Parcelable.Creator<TaskList> {
        override fun createFromParcel(source: Parcel): TaskList = TaskList(source)
        override fun newArray(size: Int): Array<TaskList?> = arrayOfNulls(size)
    }
}