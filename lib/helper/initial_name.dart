String initialName(String name) {
  var arrName = name.split(' ');
  var firstLetterOfFirstName = arrName.first[0];
  var firstLetterOfLastName = arrName.last[0];
  if (arrName.length <= 1) {
    return (firstLetterOfFirstName + firstLetterOfFirstName).toUpperCase();
  } else {
    return (firstLetterOfFirstName + firstLetterOfLastName).toUpperCase();
  }
}
