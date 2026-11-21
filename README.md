# Curso de programación y análisis de smart contracts: Ethereum y Cardano

Repositorio de trabajo final del curso.

## Empezar

### 1. Clonar (con el submódulo)

`forge-std` viaja como submódulo de git. Sin `--recurse-submodules` los tests de Ethereum no
compilan:

```bash
git clone --recurse-submodules <URL-DE-ESTE-REPO>
cd curso-smartcontracts-alumnos
```

¿Ya clonaste sin eso? Se arregla con:

```bash
git submodule update --init --recursive
```

### 2. Construir la imagen del entorno

Incluye **todas** las herramientas de las 9 clases ya preparadas con cachés listas, para que la clase no se frene por problemas de instalación. El entorno funciona con Podman o con Docker, pero
en los laboratorios se prefiere **Podman**.

Opcional: si no tenés Podman, Docker también sirve; la idea es la misma. La recomendación del curso
es usar Podman en local y en el laboratorio.

Instalación rápida de Podman (Ubuntu/Debian):

```bash
sudo apt update
sudo apt install -y podman
podman --version
```

Si usás macOS, también podés instalarlo con Homebrew:

```bash
brew install podman
```


```bash
./scripts/build-image.sh arm64      # Apple Silicon
./scripts/build-image.sh amd64      # labs Intel
```

Y para entrar:

(si tenes arm)
```bash
podman run -it --rm --userns=keep-id --name curso -v "$PWD":/curso:z curso-sc:arm64
```

(si tenes amd64)
```bash
podman run -it --rm --userns=keep-id -v --name curso "$PWD":/curso:z curso-sc:amd64
```


El -v monta **tu clon** del repositorio dentro del contenedor en /curso. De esta forma, los cambios que hagas se guardan en tu directorio local y, cuando haya material nuevo, podés actualizarlo con git pull sin necesidad de reconstruir la imagen.
Agregamos **--userns=keep-id** al ejecutar el contenedor para preservar los permisos de tu usuario sobre el directorio montado.

Si estas en el Laboratorio vas a tener que usar docker. Para eso tener que migrar la imagen:

```bash
chmod +x ./scripts/podman2docker.sh
./scripts/podman2docker.sh
```

Anota el nombre de la imagen (empieza con `sha256:elNroDeImagen`

Luego podes usar

```bash
docker run -it --rm -u root --name curso --network="host" -v "$PWD":/curso:z elNroDeImagen
```

### Instalación manual (sin contenedor)

- **Ethereum:** [Foundry](https://book.getfoundry.sh/) (`forge`, `anvil`) — ver `ethereum/README.md`
- **Cardano:** [Aiken](https://aiken-lang.org/) — ver `cardano/README.md`

## Qué hay acá

```
.
├── Containerfile              # La imagen del entorno (Podman/Docker)
├── Containerfile.devnet       # Devnet local de Cardano (Yaci)
├── ethereum/                  # Proyecto Foundry
│   ├── src/dos_por_gas_arreglado.sol
│   └── src/dos_por_gas.sol    # Versión vulnerable
└── cardano/                   # Proyecto Aiken
    ├── validators/minting_policy_vulnerable.ak
    └── validators/minting_policy_fixed.ak
```
