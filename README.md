<p align="center">
  <a href="https://heartdevs.com">
		<img src="https://heartdevs.com/dist/images/logo-he4rt2.png" alt="He4rt Devs">
  </a>
</p>

# He4rt API

Se você nunca mexeu com Elixir, você pode visitar nosso repositório com os conceitos básicos de Elixir: [Clique aqui ➡️](https://github.com/aleDsz/elixir4noobs)

## 📥 Instalando dependências

```bash
$ mix deps.get
```

## ⚙️ Configuração do ENV

Defina as variáveis de ambiente antes de executar o projeto

```bash
$ export REDIS_URL="redis://localhost:6379"
$ export MIX_ENV="dev"
$ export DATABASE_URL="ecto://root@localhost/he4rt"
```

## ✨ Iniciando servidor

Após a instalação de todas as dependências e configuração das variáveis de ambiente, você poderá iniciar o servidor com o seguinte comando:

```bash
$ iex -S mix
```

## 💃🏻 Rodando os testes

Caso você configure o `MIX_ENV=test` para definir o ambiente de testes, você precisará rodar novamente o comando para instalar as dependências necessárias para rodas os testes:

```bash
# Trocar a ENV da aplicação
$ export MIX_ENV="test"
$ export DATABASE_URL="ecto://root@localhost/test"

# Instalar as dependências
$ mix deps.get

# Rodar os seeds
$ mix setup

# Rodar os testes
$ mix test --trace

# Ou, caso queira rodar o modo TDD, execute:
$ mix test.watch --trace
```

## 👥 Contribuidores

Obrigado a todos os contirbuidores:

<table>
  <tr>
    <td align="center">
      <a href="https://github.com/chumarrento">
        <img src="https://avatars3.githubusercontent.com/u/44215764?s=460&u=451f0949e701a6e7dd47196860aaab044c62bfe7&v=4" width="100px;" alt="Lucas Pereira"/>
        <br />
        <sub>
          <b>Lucas Pereira</b>
        </sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/DanielHe4rt">
        <img src="https://avatars2.githubusercontent.com/u/6912596?s=460&v=4" width="100px;" alt="Daniel Reis"/>
        <br />
        <sub>
          <b>Daniel Reis</b>
        </sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/aleDsz">
        <img src="https://avatars1.githubusercontent.com/u/6402997?s=460&u=2c33d5f705ae622bcedc317bd88260fa1739fe86&v=4" width="100px;" alt="Alexandre de Souza"/>
        <br />
        <sub>
          <b>Alexandre de Souza</b>
        </sub>
      </a>
    </td>
  </tr>
</table>

<p align="center">
  Made with 💜
</p>

