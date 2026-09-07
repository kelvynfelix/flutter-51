# FLUTTER051 - Material Selection Pack

Aplicativo Flutter para o agendamento de eventos sociais utilizando os
principais componentes de seleção do Material Design. O formulário permite
escolher data, horário, tipo e visibilidade do evento, quantidade de convidados,
serviços adicionais, restrições alimentares e envio de lembrete automático.

## Resumo do Desenvolvimento

### 1) Qual o nome do componente Slider? Qual a variável responsável por armazenar o valor padrão do Slider?

O componente se chama `Slider`. A variável que armazena seu valor padrão é
`_quantidadeConvidadosPadrao`, definida inicialmente com 50. A variável
`_quantidadeConvidados` guarda o valor escolhido pelo usuário durante o uso do
aplicativo.

### 2) Por que um botão está marcado como OutlinedButton e o outro como ElevatedButton? Qual a diferença visual entre eles? Possuem parâmetros diferentes? Quais?

O `OutlinedButton` foi usado em Cancelar por ser uma ação secundária. Visualmente,
ele possui contorno e normalmente não tem fundo preenchido. O `ElevatedButton`
foi usado em Salvar por ser a ação principal, recebendo maior destaque com fundo
preenchido e elevação. Neste projeto, os dois recebem os mesmos parâmetros
principais: `onPressed` para a função executada e `child` para o conteúdo. Ambos
também aceitam parâmetros opcionais como `style`, `focusNode` e `autofocus`, mas
possuem estilos visuais padrão diferentes.

### 3) Qual a finalidade do método setState() dentro do RadioGroup?

O `setState()` informa ao Flutter que o valor da visibilidade foi alterado. Com
isso, o método `build()` é executado novamente e o botão Radio correspondente ao
novo valor aparece selecionado na tela.

### 4) Explique para uma criança de 10 anos o que faz o método .map na lista de itens do dropdown.

O `.map()` funciona como uma máquina que pega cada opção de uma lista, uma por
vez, e a transforma em uma peça que pode aparecer no menu. Por exemplo, ele pega
o texto "Casamento" e cria uma opção visual do Dropdown com esse texto. No final,
`toList()` junta todas as opções criadas em uma nova lista.

### 5) Como são controladas as tags selecionadas do usuário do tipo Chip (FilterChip)?

As escolhas ficam armazenadas na lista `_tagsSelecionadas`. Cada `FilterChip`
consulta `contains(tag)` para saber se está selecionado. Quando o usuário toca em
uma tag, ela é adicionada com `add()` ou removida com `remove()`, dentro de
`setState()`, para que a interface seja atualizada.
