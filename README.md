
# Calculadora IMC com SQLite

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](https://github.com/hakkinenT/flutter_calculadora_imc_sqlite/blob/main/LICENSE) 
![SQLite](https://img.shields.io/badge/sqlite-%2307405e.svg?style=for-the-badge&logo=sqlite&logoColor=white) 
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white) 
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)


## Sobre o projeto
O projeto Calculadora IMC foi desenvolvido durante o **Bootcamp Santander 2023 - Mobile com Flutter** da [DIO](https://www.dio.me/) e tem como objetivo calcular o IMC com base na altura e peso informados pelo usuário. O aplicativo armazena os dados no Banco de Dados SQLite. 

Enquanto a altura deve ser informada apenas uma vez nas Configurações do aplicativo, o peso pode ser informado várias vezes, de modo que, para cada novo peso informado, uma nova classificação do IMC é dada pelo aplicativo. Cada nova classificação IMC é apresentada em uma lista que organiza os IMCs de forma decrescente, ou seja, o último IMC cadastrado é o primeiro da lista.


## Screenshots
<p float="left">
    <img src="https://github.com/hakkinenT/assets/blob/master/flutter-projects/flutter-calculadora-imc-sqlite/settings-page.png" alt="settingspage" width="270" height="480"/>
    <img src="https://github.com/hakkinenT/assets/blob/master/flutter-projects/flutter-calculadora-imc-sqlite/home-page.png" alt="homepage" width="270" height="480"/>
</p>

## Demonstração
<p float="left">
    <img src="https://github.com/hakkinenT/assets/blob/master/flutter-projects/flutter-calculadora-imc-sqlite/altura-screen.gif" alt="alturagif" width="270" height="480"/>
    <img src="https://github.com/hakkinenT/assets/blob/master/flutter-projects/flutter-calculadora-imc-sqlite/cadastrar-imc-screen.gif" alt="cadastrarImcgif" width="270" height="480"/>
</p>

## Funcionalidades
- Calcular IMC
- Excluir IMC

## Tecnologias Utilizadas
- Flutter
- Dart
- [sqflite](https://pub.dev/packages/sqflite)

## Aprendizados
Nesse projeto foi possível aprender sobre a persistência de dados em Flutter usando o Banco de Dados SQLite.

## Rodando localmente

Clone o projeto

```bash
  git clone https://github.com/hakkinenT/flutter_calculadora_imc_sqlite.git
```

Entre no diretório do projeto

```bash
  cd flutter_calculadora_imc_sqlite
```

Instale as dependências

```bash
  flutter pub get
```

Rode a aplicação

```bash
  flutter run
```


## Autores

- [@hakkinenT](https://github.com/hakkinenT)
