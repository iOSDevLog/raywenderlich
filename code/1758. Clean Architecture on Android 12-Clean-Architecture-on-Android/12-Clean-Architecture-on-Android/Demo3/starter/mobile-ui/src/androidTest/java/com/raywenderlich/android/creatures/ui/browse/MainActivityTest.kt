package com.raywenderlich.android.creatures.ui.browse

import android.support.test.espresso.Espresso
import android.support.test.espresso.assertion.ViewAssertions
import android.support.test.espresso.contrib.RecyclerViewActions
import android.support.test.espresso.matcher.ViewMatchers
import android.support.test.rule.ActivityTestRule
import android.support.test.runner.AndroidJUnit4
import android.support.v7.widget.RecyclerView
import com.nhaarman.mockito_kotlin.whenever
import com.raywenderlich.android.creatures.domain.model.Creature
import com.raywenderlich.android.creatures.ui.R
import com.raywenderlich.android.creatures.ui.test.TestApplication
import com.raywenderlich.android.creatures.ui.test.utils.CreatureFactory
import com.raywenderlich.android.creatures.ui.test.utils.RecyclerViewMatcher
import io.reactivex.Flowable
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class MainActivityTest {

  @Rule
  @JvmField
  val activity = ActivityTestRule<MainActivity>(MainActivity::class.java, false, false)

  @Test
  fun activityLaunches() {
    stubCreatureRepositoryGetCreatures(Flowable.just(CreatureFactory.makeCreatureList(2)))
    activity.launchActivity(null)
  }

  @Test
  fun creaturesDisplay() {
    val creatures = CreatureFactory.makeCreatureList(1)
    stubCreatureRepositoryGetCreatures(Flowable.just(creatures))
    activity.launchActivity(null)

    checkCreatureDetailsDisplay(creatures[0], 0)
  }

  @Test
  fun creaturesAreScrollable() {
    val creatures = CreatureFactory.makeCreatureList(20)
    stubCreatureRepositoryGetCreatures(Flowable.just(creatures))
    activity.launchActivity(null)

    creatures.forEachIndexed { index, creature ->
      Espresso.onView(ViewMatchers.withId(R.id.recycler_creatures)).perform(RecyclerViewActions.
          scrollToPosition<RecyclerView.ViewHolder>(index))
      checkCreatureDetailsDisplay(creature, index) }
  }

  private fun checkCreatureDetailsDisplay(creature: Creature, position: Int) {
    Espresso.onView(RecyclerViewMatcher.withRecyclerView(R.id.recycler_creatures).atPosition(position))
        .check(ViewAssertions.matches(ViewMatchers.hasDescendant(ViewMatchers.withText(creature.firstName))))
    Espresso.onView(RecyclerViewMatcher.withRecyclerView(R.id.recycler_creatures).atPosition(position))
        .check(ViewAssertions.matches(ViewMatchers.hasDescendant(ViewMatchers.withText(creature.planet))))
  }

  private fun stubCreatureRepositoryGetCreatures(single: Flowable<List<Creature>>) {
    whenever(TestApplication.appComponent().creatureRepository().getCreatures())
        .thenReturn(single)
  }
}