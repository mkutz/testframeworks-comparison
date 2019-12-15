@Grab('org.codehaus.groovy:groovy-all:2.5.8@pom')
@Grab('org.spockframework:spock-core:1.3-groovy-2.5')
import spock.lang.*

import java.time.LocalDate

class UserServiceSpec extends Specification {

  @Subject
  UserService userService = new UserService(repositoryMock)

  UserRepository repositoryMock = Mock()

  User someUser = new User("suser", "Some", "User", LocalDate.of(1982, 2, 19))

  def "registerUser persists the user data via UserRepository"() {
    when:
    userService.registerUser(someUser)

    then:
    1 * repositoryMock.saveUser(someUser)
  }

  def "registerUser throws IllegalArgumentException if the username was registered before"() {
    given:
    repositoryMock.findByUsername(someUser.username) >> { throw new IllegalArgumentException("user already exists") }

    when:
    userService.registerUser(someUser)

    then:
    thrown(IllegalArgumentException)

    and:
    0 * repositoryMock.saveUser(someUser)
  }
}
