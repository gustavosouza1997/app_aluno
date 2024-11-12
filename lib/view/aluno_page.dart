import 'package:flutter/material.dart';
import '../model/aluno.dart';
import '../presenter/aluno_presenter.dart';
import 'aluno_view.dart';
import 'aluno_form_page.dart';

class AlunoPage extends StatefulWidget {
  const AlunoPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AlunoPageState createState() => _AlunoPageState();
}

class _AlunoPageState extends State<AlunoPage> implements AlunoView {
  late AlunoPresenter presenter;
  List<Aluno> alunos = [];
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    presenter = AlunoPresenter(this);
    presenter.fetchAlunosFirebase();
  }

  @override
  void displayAlunos(List<Aluno> alunos) {
    setState(() {
      this.alunos = alunos;
      errorMessage = '';
    });
  }

  @override
  void showError(String error) {
    setState(() {
      errorMessage = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Lista de Alunos',
          style: TextStyle(
            color: Color(0xFF2D2D2D),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.blue),
            onPressed: () async {
              bool? alunoAdicionado = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AlunoFormPage(presenter: presenter),
                ),
              );
              if (alunoAdicionado == true) {
                presenter.fetchAlunosFirebase();
              }
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[50],
      body: errorMessage.isEmpty
          ? ListView.builder(
              itemCount: alunos.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        alunos[index].nome[0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      alunos[index].nome,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      'Idade: ${alunos[index].idade} | Turma: ${alunos[index].turma}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                errorMessage,
                style: const TextStyle(
                    color: Colors.redAccent, fontSize: 16),
              ),
            ),
    );
  }
}
