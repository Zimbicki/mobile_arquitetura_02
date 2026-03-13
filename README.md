# mobile_arquitetura_02

# 1. Em qual camada foi implementado o mecanismo de cache? Explique por que essa decisão é adequada dentro da arquitetura proposta.

O mecanismo de cache foi implementado na camada de Data (Dados), através da criação de um novo `DataSource` exclusivo (`ProductCacheDatasource`). A responsabilidade por orquestrar a lógica de quando utilizar esse cache (a nossa estratégia de fallback) foi atribuída ao `Repository` (`ProductRepositoryImpl`). Essa decisão é ideal porque as camadas superiores de negócio (Domain) e de apresentação (UI/ViewModel) não devem saber de onde ou como os dados vêm. Toda a complexidade de decidir se o dado vem da internet ou do armazenamento interno (memória) fica encapsulada e isolada na camada de infraestrutura de dados.

# 2. Por que o ViewModel não deve realizar chamadas HTTP diretamente?

O ViewModel tem como foco principal gerenciar o estado da apresentação e orquestrar as interações do usuário. Fazer chamadas HTTP diretamente nele viola o Princípio da Responsabilidade Única (SRP) e cria um alto acoplamento da interface com a infraestrutura de rede (bibliotecas e URLs). Se algo na infraestrutura da web for alterado, ou se quisermos reaproveitar essa chamada de API em outra tela, todo o código ficaria bloqueado/duplicado. Ademais, impede a implantação limpa de estratégias como o cache off-line sem "poluir" a classe.

# 3. O que poderia acontecer se a interface acessasse diretamente o DataSource?

Ocorreria o que chamamos de forte acoplamento. A Interface (UI) ficaria completamente dependente da engrenagem técnica dos dados (por exemplo, lidaria diretamente com parsing de JSON). Pulando a camada do Repositório perderíamos nossa recém-criada coordenação "API versus Cache". No futuro, atualizar o App (ex: migrar de uma API REST para consultas locais) causaria a quebra generalizada e nos faria reescrever todos os widgets, violando completamente o conceito do Clean Architecture de independência de frameworks.

# 4. Como essa arquitetura facilitaria a substituição da API por um banco de dados local?

Graças ao princípio da Inversão de Dependência. Como as regras de UI estão fixadas com a interface `ProductRepository` abstrata (estipulada pelo Domain), basta que possamos criar um novo Data Source (digamos, `ProductDatabaseDatasource`) que recupere do SQLite ou Hive. Em seguida, injetamos nele o nosso Repositório sem modificar uma vírgula de código nas telas do Flutter, nos ViewModels e nas entidades do projeto. A mudança seria cirúrgica e com zero impacto visual ou na regra de negócio.
