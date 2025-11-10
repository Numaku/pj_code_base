class Validate {

  //validate email
  static String? validateEmail (String? value){
    if (value == null || value.isEmpty){
      return "Vui lòng nhập Email!";
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)){
      return "Email không hợp lệ!";
    }
    return null;
  }

  //validate pass
  static String? validatePass (String? value){
    if (value == null || value.isEmpty){
      return "Vui lòng nhập mật khẩu!";
    }
    final passRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$');
    if (!passRegex.hasMatch(value)){
      return "Mật khẩu phải bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt!";
    }
    return null;
  }

  //validate nhắc lại pass
  static String? validateConfirmPass (String? value, String password){
    if (value == null || value.isEmpty){
      return "Vui lòng nhập lại mật khẩu!";
    }
    if (value != password){
      return "Mật khẩu không khớp!";
    }
  }

  //validate sđt
  static String? validatePhone (String? value){
    if (value == null || value.isEmpty){
      return "Vui lòng nhập số điện thoại!";
    }
    final phoneRegex = RegExp(r'^[0-9]+$');
    if (value.length != 10 || !phoneRegex.hasMatch(value)){
      return "Số điện thoại không đúng";
    }
  }

  static String? validateUserName (String? value){
    if (value == null || value.isEmpty){
      return "Vui lòng nhập tên tài khoản!";
    }
    if (value.length > 14){
      return "Tên tài khoản quá dài";
    }
  }


  static String? validateOtp (String? value){

    if (value == null || value.isEmpty){
      return "Vui lòng nhập mã OTP!";
    }
    if (value != "1234"){
      return "Mã OTP không đúng";
    }
  }



}