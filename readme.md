# Planet Explorer 🌌

Uma aplicação para explorar planetas, estrelas e galáxias. Desenvolvida com **Node.js** (backend) e **Vue.js** (frontend).

---

## 📋 Pré-requisitos

* Node.js (versão 18 ou superior)
* PostgreSQL (local ou Neon)
* npm ou yarn

---

## 🗄️ Configuração do Banco de Dados

### Opção 1: Neon (PostgreSQL na nuvem - gratuito)

1. Acesse Neon e crie uma conta.
2. Crie um novo projeto.
3. Anote a string de conexão fornecida.

### Opção 2: PostgreSQL local

1. Instale o PostgreSQL em sua máquina.
2. Crie um banco de dados chamado `planetdb`.

### Executando os Scripts do Banco de Dados

O projeto inclui dois scripts SQL na pasta `backend/database/`:

* `ddl.sql`: Cria todas as tabelas e constraints.
* `seed.sql`: Insere dados iniciais para teste.

**Passos para executar os scripts:**

1. Crie o banco de dados manualmente (caso não exista).
2. Execute o script `ddl.sql` no banco de dados para criar a estrutura das tabelas.
3. Execute o script `seed.sql` no banco de dados para popular o banco com dados iniciais.

**Exemplo de comando para executar os scripts via `psql`:**

```bash
psql -h localhost -U seu_usuario -d planetdb -f backend/database/ddl.sql
psql -h localhost -U seu_usuario -d planetdb -f backend/database/seed.sql
```

---

## 🚀 Como Executar o Projeto

### 1. Clonar o Repositório

```bash
git clone https://github.com/yurisakuma/planet-app
cd planet-app
```

### 2. Configurar e Executar o Backend

```bash
cd backend
npm install
```

Crie um arquivo `.env` com as variáveis abaixo (exemplo):

```env
DATABASE_URL=sua_string_de_conexao_postgresql
PORT=3001
```

```bash
npm run dev
```

O backend estará disponível em `http://localhost:3001`.

### 3. Configurar e Executar o Frontend

```bash
cd frontend
npm install
npm run dev
```

O frontend estará disponível em `http://localhost:3000`.

---

## 🎯 Funcionalidades

* **Listar Planetas:** Visualize todos os planetas com filtros avançados.
* **Adicionar Planetas:** Formulário com validação para cadastrar novos planetas.
* **Filtros:** Pesquisa por nome, filtro por massa e tipo de planeta.

---

## 🛠️ Comandos Úteis

**Backend**

```bash
npm run dev
npm start
```

**Frontend**

```bash
npm run dev
npm run build
npm run preview
```

---

Desenvolvido para fins educacionais 🎓
