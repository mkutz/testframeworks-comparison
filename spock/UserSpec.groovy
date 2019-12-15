@Grab('org.codehaus.groovy:groovy-all:2.5.8@pom')
@Grab('org.spockframework:spock-core:1.3-groovy-2.5')
import spock.lang.*
import java.time.LocalDate

@Subject(User)
class UserSpec extends Specification {

  def "has all attributes"() {
    given:
    subject = new User("tdoe", "Timmy", "Doe", LocalDate.now())

    expect:
    verifyAll(subject) {
      username == "tdoe"
      firstname == "Timmy"
      lastname == "Doe"
      birthday == LocalDate.now()
    }
  }

  @Unroll
  def "adult born #birthday is of age"(LocalDate birthday) {
    expect:
    new User("tdoe", "Timmy", "Doe", birthday).ofAge

    where:
    birthday << [LocalDate.now().minusYears(18), LocalDate.now().minusYears(37)]
  }

  @Unroll
  def "child born #birthday is not of age"(LocalDate birthday) {
    expect:
    !new User("rdoe", "Rose", "Doe", birthday).ofAge

    where:
    birthday << [LocalDate.now().minusYears(18).plusDays(1), LocalDate.now().minusYears(5)]
  }

  def "unborn can't be created"() {
    when:
    new User("hdoe", "Hope", "Doe", LocalDate.now().plusDays(1))

    then:
    IllegalArgumentException e = thrown()
    e.message == "future birthday"
  }
}