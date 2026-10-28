# Inácio Rocha — landing page

Projeto independente em HTML, CSS e JavaScript, sem dependências ou etapa de build.

## Visualizar

Na pasta deste projeto:

```sh
python3 -m http.server 8001 --bind 127.0.0.1
```

Abra http://localhost:8001.

## Conteúdo e contato

O projeto segue o molde enviado, com fotos de Inácio e recortes das imagens decorativas do próprio molde. Os recortes menores dos cards e fundos podem ser substituídos por originais de maior resolução quando disponíveis.

WhatsApp configurado exatamente conforme informado: `+55 69 9377-6427`, usando `https://wa.me/556993776427`.

O vídeo completo da reportagem não foi fornecido. Os botões de reportagem abrem uma prévia e permitem solicitar o vídeo pelo WhatsApp. Para incorporar um vídeo, substituir o conteúdo de `#reportagem-dialog` em `index.html` pelo player/link real.

Os valores das cotas e o e-mail também não foram fornecidos. O diálogo de parceria apresenta as contrapartidas do molde e permite solicitar uma proposta; o rodapé usa o WhatsApp real no lugar do e-mail ilustrativo.

## Arquivos

- `index.html`: conteúdo, ícones SVG e diálogos.
- `assets/style.css`: layout responsivo, fontes locais e estilos.
- `assets/refinements.css`: ajustes de tipografia, proporções, botões e composição baseados no molde.
- `assets/main.js`: menu, diálogos e links de WhatsApp.
- `assets/images/`: fotos originais e versões WebP otimizadas.
- `qa/verify.rb`: verificação de layout, menu, diálogos, imagens e contatos com Selenium.
- `qa/report.json`: resultado da última verificação.

## Publicação

Publicar `index.html` e a pasta `assets/` em hospedagem estática. O ZIP de entrega já contém esses arquivos. Não é necessário publicar a pasta `qa/`.
