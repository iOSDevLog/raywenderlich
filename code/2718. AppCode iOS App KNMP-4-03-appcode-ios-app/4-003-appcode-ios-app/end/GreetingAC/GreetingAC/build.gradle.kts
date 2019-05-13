plugins {
    kotlin("multiplatform") version "1.3.20"
    kotlin("xcode-compat") version "0.1"
}

kotlin {
    xcode {
        setupApplication("GreetingAC")
    }
}