
# 🎥 Demonstração em vídeo

Esta seção serve para adicionar um vídeo demonstrando o funcionamento completo do laboratório.

Sugestão de conteúdo do vídeo:

- Login Flutter
- Abertura do navegador
- Tela de login do Keycloak
- Fluxo Authorization Code + PKCE
- Retorno para o app via deep link
- Recebimento do access token
- Chamada do endpoint `/me`
- Teste de autorização com `/admin/test`

## Estrutura recomendada

```text
docs/
 ├── KEYCLOAK_FLUTTER_SPRING_PKCE_GUIDE_DETALHADO.md
 ├── demo.mp4
 └── demo.gif
```

---

## Opção 1 — Link simples para o vídeo

Se o arquivo `demo.mp4` estiver na mesma pasta do markdown:

```md
# 🎥 Demonstração do Login Flutter + Keycloak

Arquivo de demonstração:

- [demo.mp4](./demo.mp4)
```

---

## Opção 2 — GIF + vídeo completo (recomendado)

Muito usado em READMEs profissionais.

```md
# 🎥 Demonstração

![demo](./demo.gif)

Vídeo completo:
- [demo.mp4](./demo.mp4)
```

---

## Opção 3 — HTML inline

Alguns renderizadores Markdown suportam `<video>`:

```md
# 🎥 Demonstração

<video width="800" controls>
  <source src="./demo.mp4" type="video/mp4">
</video>
```

Observação:
- GitHub pode limitar renderização inline dependendo do viewer.
- A opção GIF + link costuma ser mais compatível.

---

## Sugestão profissional

Adicionar esta seção próxima de:

```text
21. Como testar tudo ponta a ponta
```

pois o vídeo ajuda a visualizar o fluxo completo explicado no guia.
