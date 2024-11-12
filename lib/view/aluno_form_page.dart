import 'package:app_aluno/model/aluno.dart'; // Importa o modelo Aluno.
import 'package:flutter/material.dart'; // Importa o pacote de UI do Flutter.

import '../presenter/aluno_presenter.dart'; // Importa o AlunoPresenter para a comunicação entre o formulário e o backend.

class AlunoFormPage extends StatefulWidget {
  final AlunoPresenter presenter; // O presenter que gerencia a lógica do formulário.

  // Construtor da página de formulário. Recebe o presenter como argumento.
  const AlunoFormPage({super.key, required this.presenter});

  @override
  // ignore: library_private_types_in_public_api
  _AlunoFormPageState createState() => _AlunoFormPageState(); // Cria o estado da página.
}

class _AlunoFormPageState extends State<AlunoFormPage> {
  final _formKey = GlobalKey<FormState>(); // Chave global para identificar o formulário e validar os campos.
  final _codigoController = TextEditingController(); // Controlador para o campo de código do aluno.
  final _nomeController = TextEditingController(); // Controlador para o campo de nome.
  final _idadeController = TextEditingController(); // Controlador para o campo de idade.
  final _turmaController = TextEditingController(); // Controlador para o campo de turma.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Fundo branco no estilo Fluent.
        title: const Text(
          'Cadastrar Aluno', // Título do AppBar.
          style: TextStyle(
            color: Colors.black, // Texto preto.
            fontWeight: FontWeight.bold, // Negrito no estilo clean.
          ),
        ),
        iconTheme: const IconThemeData(
            color: Colors.black), // Ícone da seta de voltar em preto.
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0), // Define o espaçamento interno.
        child: Form(
          key: _formKey, // Define a chave do formulário para validar.
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Alinha os elementos à esquerda.
            children: [
              // Campo de texto para o código do aluno.
              _buildTextField(
                controller: _codigoController,
                label: 'Código',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o código do aluno'; // Mensagem de erro se o campo estiver vazio.
                  }
                  return null; // Sem erro.
                },
              ),
              SizedBox(height: 20), // Espaçamento vertical.

              // Campo de texto para o nome do aluno.
              _buildTextField(
                controller: _nomeController,
                label: 'Nome',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome do aluno';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20), // Espaçamento vertical.

              // Campo de texto para a idade do aluno.
              _buildTextField(
                controller: _idadeController,
                label: 'Idade',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a idade do aluno';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20), // Espaçamento vertical.

              // Campo de texto para a turma do aluno.
              _buildTextField(
                controller: _turmaController,
                label: 'Turma',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a turma do aluno';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30), // Espaçamento maior antes do botão.

              // Botão para salvar o aluno.
              SizedBox(
                width: double.infinity, // Botão com largura máxima.
                child: ElevatedButton(
                  onPressed: () {
                    // Valida o formulário quando o botão é pressionado.
                    if (_formKey.currentState!.validate()) {
                      // Se todos os campos são válidos, cria uma nova instância de Aluno.
                      Aluno aluno = Aluno(
                        codigo: int.parse(_codigoController.text), // Converte o código para int.
                        nome: _nomeController.text, // Atribui o nome do controlador.
                        idade: int.parse(_idadeController.text), // Converte a idade para int.
                        turma: _turmaController.text, // Atribui a turma do controlador.
                      );
                      // Chama o método addAluno do presenter para adicionar o aluno.
                      widget.presenter.addAlunoFirebase(aluno).then((_) {
                        // Após adicionar o aluno, fecha a página e retorna true.
                        Navigator.pop(context, true);
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade400, // Cor vibrante para o botão.
                    padding: const EdgeInsets.symmetric(vertical: 16), // Espaçamento interno vertical.
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Borda arredondada mais suave.
                    ),
                    elevation: 4, // Adiciona uma leve sombra para o efeito de profundidade.
                  ),
                  child: const Text(
                    'Salvar', // Texto do botão.
                    style: TextStyle(
                      color: Colors.white, // Texto branco.
                      fontSize: 18, // Tamanho maior para o texto.
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função reutilizável para criar campos de texto.
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
