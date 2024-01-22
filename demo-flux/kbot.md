# Kbot telegram bot

The Kbot Telegram bot consists of two main components:

**Telegram Bot:**
   - Serves as the frontend for interacting with users on Telegram.
   - Created using BotFather Telegram bot.

**Golang Backend:**
   - Responsible for handling requests and the bot's behavior.
   - Compiled from Golang source files into an executable for specified architecture.

## Quick start guide

### Prerequisites

- Golang installed
- Telegram Bot token (obtained on Telegram Bot creation stage)
- Make installed (optional)*

### Golang installation

If Golang is not installed in your OS, you can follow [Golang installation guide](https://go.dev/doc/install)

### *Make installation

In Debian-like Linux like Ubuntu, run:
```bash
sudo apt install build-essential
```
Additional documentation can be found at the [GNU Make Webpage](https://www.gnu.org/software/make/)

### Telegram Bot creation

To create a Telegram bot, follow these instructions:
- Open Telegram app and enter "BotFather" in the searchbar
- Start chat with BotFather and enter "/start"
- Click "/newbot" link and follow instructions
- After bot is created, click "/mybots" link in BotFather chat
- Find and click your bot's button, then click "API Token"
- Copy and save the API Token when it appears

### Clone git repository



### Backend application build

From your project's root directory, run the following commands:

Satisfy possible dependencies:
```bash
go get
```

Build kbot executable:
```bash
go build
```

### Start bot

In order for Kbot to be able to cooperate with it's Telegram frontend, the TELE_TOKEN environment variable needs to be exported. This can be done similar to the following example (value is random):

Copy your API Token to Clipboard, then safely read TELE_TOKEN env variable by running the following command:
```bash
read -s TELE_TOKEN
```
and press \<Ctri-V>, then \<Enter>


Now you can start the kbot:
```bash
./kbot start
```

### Usage:

To start using your Telegram bot, open the Telegram app and search for your bot's name, then click it to open chat window and enter "/start".

Now you can enter commands, like:

"/name" - Returns bot's name

"/time" - Returns current time

## Containerized launch

Another way of running Kbot Telegram bot is inside the Docker container by direct "docker run" or within a Kubernetes cluster. 

Prerequisites:

Mandatory:
- Make installed (see installation guide above)
- Docker installed

Optional:
- Kubernetes cluster

### Docker installation

If Docker is not installed in your system, please follow the [Doceker Installation Guide](https://www.docker.com/get-started/)

### Docker Image creation

Kbot app can be packed into a docker image for running on specific OS and/or Architecture by running command like in example below:
```bash
make image TARGETOS="linux" TARGETARCH="amd64"
```

Then you can push your image to a container registry (docker hub in our case):
```bash
make push TARGETOS="linux" TARGETARCH="amd64"
```

Now the image can be launched in container directly with "docker run", or it can be a part of deployment in Kubernetes cluster.