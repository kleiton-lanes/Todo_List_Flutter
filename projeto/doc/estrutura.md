# Diretrizes de Estrutura do Projeto Flutter com Clean Architecture e BLoC

## Visão Geral da Arquitetura

A estrutura segue os princípios da Clean Architecture propostos por Robert C. Martin (Uncle Bob), adaptados para Flutter com o padrão BLoC conforme recomendado por Felix Angelov e a equipe do Flutter.

```
lib/
├── core/                     # Componentes centrais e utilitários
│   ├── errors/              # Tratamento de erros
│   ├── network/             # Configurações de rede
│   ├── theme/               # Temas e estilos
│   └── utils/               # Utilitários gerais
│
├── data/                    # Camada de Dados
│   ├── datasources/         # Fontes de dados (local/remoto)
│   │   ├── local/
│   │   └── remote/
│   ├── models/             # Modelos de dados
│   └── repositories/       # Implementações dos repositórios
│
├── domain/                 # Regras de Negócio
│   ├── entities/          # Entidades de negócio
│   ├── repositories/      # Contratos dos repositórios
│   └── usecases/         # Casos de uso
│
├── presentation/          # Interface do Usuário
│   ├── bloc/             # BLoCs e Cubits
│   │   ├── common/       # BLoCs compartilhados
│   │   └── features/     # BLoCs específicos
│   ├── pages/           # Telas principais
│   ├── widgets/         # Widgets reutilizáveis
│   └── navigation/      # Navegação e rotas
│
└── di/                  # Injeção de Dependência
    └── injection.dart   # Configuração do GetIt ou outro DI
```

## Princípios e Diretrizes

### 1. Separação de Responsabilidades

#### Camada de Apresentação (presentation/)
- **BLoC**: Gerencia o estado da aplicação
- **Pages**: Telas que consomem os BLoCs
- **Widgets**: Componentes reutilizáveis
- Princípio: Não deve conter lógica de negócio

#### Camada de Domínio (domain/)
- Contém as regras de negócio
- Independente de frameworks
- Define contratos (interfaces) para repositórios
- Use Cases representam ações do usuário

#### Camada de Dados (data/)
- Implementa repositórios
- Gerencia fontes de dados
- Converte DTOs para Entidades

### 2. Padrões do BLoC

#### Estrutura de um BLoC
```dart
├── bloc/
│   ├── feature_bloc.dart        # Classe BLoC
│   ├── feature_event.dart       # Eventos
│   └── feature_state.dart       # Estados
```

#### Diretrizes
- Um BLoC por feature
- Estados imutáveis
- Eventos descritivos
- Tratamento de erros consistente

### 3. Injeção de Dependência

- Usar GetIt ou injectable
- Registrar dependências por módulo
- Favorecer injeção por construtor

### 4. Testes

```
test/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   └── usecases/
└── presentation/
    └── bloc/
```

## Convenções de Código

### 1. Nomenclatura
- **Arquivos**: snake_case
- **Classes**: PascalCase
- **Variáveis/Métodos**: camelCase
- **Constantes**: SCREAMING_SNAKE_CASE

### 2. BLoC
```dart
// Eventos
abstract class FeatureEvent {}
class LoadFeature extends FeatureEvent {}

// Estados
abstract class FeatureState {}
class FeatureInitial extends FeatureState {}
```

### 3. Entidades
```dart
class EntityName extends Equatable {
  final String id;
  
  const EntityName({required this.id});
  
  @override
  List<Object> get props => [id];
}
```

## Fluxo de Dados

```
UI -> Event -> BLoC -> UseCase -> Repository -> DataSource
```

1. UI dispara eventos
2. BLoC processa eventos
3. UseCase executa lógica de negócio
4. Repository coordena fontes de dados
5. DataSource acessa dados externos/locais

## Recomendações de Pacotes

- **Estado**: flutter_bloc
- **DI**: get_it + injectable
- **Network**: dio
- **Local Storage**: hive ou shared_preferences
- **Imutabilidade**: freezed
- **Equalidade**: equatable
- **Validação**: either_dart ou dartz

## Boas Práticas

1. **Código Limpo**
   - Métodos pequenos e focados
   - Nomes descritivos
   - Documentação quando necessário

2. **Gerenciamento de Estado**
   - Usar BLoC para estado complexo
   - Evitar setState
   - Estados imutáveis

3. **Performance**
   - Const constructors
   - ListView.builder para listas
   - Cached network image

4. **Testes**
   - Testes unitários para UseCases
   - Testes de BLoC
   - Testes de Widget quando necessário

---

> Documento gerado em 30 de outubro de 2025
> Baseado nas recomendações de Felix Angelov (flutter_bloc) e princípios do Clean Architecture