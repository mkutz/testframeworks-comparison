import groovy.transform.Canonical
import java.time.LocalDate

@Canonical
class User {
  
  String username
  String firstname
  String lastname
  LocalDate birthday

  User(String username, firstname, lastname, birthday) {
    if (birthday.isAfter(LocalDate.now())) {
      throw new IllegalArgumentException("future birthday")
    }
    this.username = username
    this.firstname = firstname
    this.lastname = lastname
    this.birthday = birthday
  }

  boolean isOfAge() {
    return !birthday.isAfter(LocalDate.now().minusYears(18))
  }
}