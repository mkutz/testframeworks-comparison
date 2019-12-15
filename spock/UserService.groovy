import groovy.transform.Immutable

@Immutable
class UserService {

  UserRepository repository

  void registerUser(User user) {
    if (repository.findByUsername(user.username)) {
      throw new IllegalArgumentException("user already exists")
    }
    repository.saveUser(user)
  }
}
