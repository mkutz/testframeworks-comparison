interface UserRepository {

  User findByUsername(String username)

  void saveUser(User user)
}