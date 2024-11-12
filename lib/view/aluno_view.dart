import 'package:app_aluno/model/aluno.dart';

abstract class AlunoView {
  void displayAlunos(List<Aluno> alunos);
  void showError(String error);
}