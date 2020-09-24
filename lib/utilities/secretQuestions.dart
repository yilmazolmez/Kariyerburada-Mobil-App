class SecretQuestions {
  String name;

  SecretQuestions(this.name);

  static List<SecretQuestions> getSecretQuestions() {
    return <SecretQuestions>[
      SecretQuestions('İlk evcil hayvanınızın adı'),
      SecretQuestions('İlk aracınızın modeli'),
      SecretQuestions('Babanızın ortanca ismi'),
      SecretQuestions('Çocukluk Lakabınız'),
      SecretQuestions('İlkokul öğretmeniniz'),
    ];
  }
}
