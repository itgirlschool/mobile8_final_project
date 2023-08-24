class UserDto {
  final String email;
  final String name;
  final String phone;
  final String address;
  final String id;
  final String password;

  UserDto({
    required this.email,
    this.name = '',
    this.phone = '',
    this.address = '',
    this.id = '',
    this.password = '',
  });
}