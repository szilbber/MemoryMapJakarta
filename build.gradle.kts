plugins {
    java
    war
}

group = "org.example"
version = "1.0.0"

java {
    toolchain {
        languageVersion = JavaLanguageVersion.of(21)
    }
}

repositories {
    mavenCentral()
}

dependencies {
    compileOnly("jakarta.platform:jakarta.jakartaee-api:10.0.0")
    runtimeOnly("org.postgresql:postgresql:42.7.7")
    implementation("jakarta.servlet.jsp.jstl:jakarta.servlet.jsp.jstl-api:3.0.2")
    runtimeOnly("org.glassfish.web:jakarta.servlet.jsp.jstl:3.0.1")
    testImplementation("org.junit.jupiter:junit-jupiter:5.12.2")
}

tasks.withType<Test> {
    useJUnitPlatform()
}
