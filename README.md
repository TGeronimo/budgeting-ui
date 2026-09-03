# flutter_app_test

A new Flutter project.

# Improvements

1- Manter o snack bar ativo por mais tempo
2- Melhorar o tratamento de exceções para enviar mensagens mais claras para o usuário. Nesse caso, poderia ter subido a mensagem "E-mail já cadastrado!".
3- Log para as requisições, e para as respostas do servidor.

## Getting Started

This is a project to build an UI for the Budgeting application back-end.

It implements:

### Landing page
route: '/landing_page'
The landing page contains two buttons to acces a log-in page and a sign-up page.

### Sign-up page
route: '/sign_up_page'
The sign-up page has a form with a text field for e-mail input with validations to accept only a string containing '@' or '.'.
The password field is obscured by default, have hints to activate password managers and is validated using a set of rules:
- 12 characters long minimun
- at least one number
- at least one capital letter
- at leart one symbol

#### Problema para centralizar os campos do Form resolvido
Utilizado o LayoutBuilder tendo um AnimatedContainer como child para permitir a rolagem quando o teclado aparece na tela mobile.

```Dart
return Scaffold(
  body: SafeArea(
    child: LayoutBuilder(
      builder: (context, viewportConstraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            // Subtrai apenas o padding vertical interno (24 top + 24 bottom)
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight - 48,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Form( // ... resto do código
```
**A causa raiz e o papel do LayoutBuilder**

O problema original acontecia devido à forma como o Flutter transmite restrições de tamanho (constraints).

Em uma tela comum, o Scaffold diz ao seu filho: "Você tem no máximo a altura X da tela". Porém, quando você insere um SingleChildScrollView, ele altera essa regra e diz para os seus filhos: "A altura aqui é infinita, cresça o quanto precisar para caber tudo".

Quando a Column recebe uma altura infinita:

Ela encolhe verticalmente para o tamanho exato dos seus botões e inputs.

O widget Center tenta centralizar a Column, mas como a caixa interna tem o tamanho exato do conteúdo, não existe "espaço sobrando" vertical para centralizar.

O SingleChildScrollView simplesmente posiciona essa caixa no topo da tela.

O LayoutBuilder entra exatamente para interceptar as restrições da tela antes do scroll. Ele olha para o contexto acima do SingleChildScrollView (onde a altura ainda é limitada pela janela/dispositivo) e consulta qual é o espaço real disponível.

**O que é o viewportConstraints?**

O viewportConstraints é apenas o nome dado ao objeto do tipo BoxConstraints recebido no callback do LayoutBuilder. Ele carrega as métricas da área visível (viewport) onde o widget será desenhado:

* viewportConstraints.maxHeight: Informa a altura máxima exata que a janela ou tela possui disponível naquele instante (já descontando barras de navegação do sistema se estiver abaixo do SafeArea).

Ao repassar esse valor para o minHeight do container interno, forçamos o container a ter no mínimo a altura da tela. Com uma caixa do tamanho da tela, a Column passa a ter espaço sobrando e o mainAxisAlignment: MainAxisAlignment.center finalmente consegue empurrar o formulário para o centro exato.

**Qual a função do AnimatedContainer?**

O AnimatedContainer atua da mesma forma que um Container convencional ou ConstrainedBox, mas com o diferencial de animar suavemente a transição caso suas propriedades (como altura, largura ou constraints) mudem.

Nesta solução, ele desempenha duas funções:

1- Aplicação do minHeight: Define a regra de que o conteúdo deve ter a altura da área visível para garantir a centralização.

2- Suavização no Redimensionamento: Quando a janela da aplicação Web/Desktop é redimensionada ou quando o teclado virtual abre no mobile, a altura do viewport muda instantaneamente. O AnimatedContainer faz com que o formulário se reajuste ao novo centro com uma transição suave (de 200ms), evitando que o layout "pule" bruscamente na tela.