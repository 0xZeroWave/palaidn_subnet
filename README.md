# Palaidn - Decentralized Fraud Detection on Bittensor

**Harnessing the power of decentralization for fraud detection. Learn how Palaidn leverages the Bittensor Network to offer robust fraud detection through a unique incentive mechanism for miners and validators.**

![Palaidn](docs/palaidn.png)

:no_entry_sign:**The Problem:**

The current fraud detection landscape, particularly in centralized systems, poses significant challenges. Users face data breaches and privacy issues, leading to a lack of trust in online transactions. Additionally, centralized fraud detection systems are prone to inefficiencies and high operational costs, making them less accessible for smaller organizations.

Cryptocurrency transactions are particularly vulnerable, with frequent hacking attempts targeting wallets and network vulnerabilities. The decentralized nature of cryptocurrencies makes it difficult to implement traditional fraud detection methods, leading to substantial financial losses and compromised network integrity.

:bulb:**The Solution:**

Palaidn emerges as a revolutionary solution, utilizing blockchain technology to create a decentralized and incentivized fraud detection environment for crypto transactions. By distributing control and data across a decentralized network, Palaidn enhances transparency and trust, making fraud detection more efficient and cost-effective.

In addition to transaction monitoring, Palaidn leverages AI to scan for vulnerabilities in code dependencies. This proactive approach addresses potential security risks before they can be exploited, further enhancing the security of the cryptocurrency ecosystem. By incentivizing participants with TAO tokens, Palaidn ensures robust and continuous fraud detection and vulnerability scanning, democratizing access to these critical security measures.

:link:**Useful Links:** <br>

- [webpage](https://www.palaidn.com) <br>
- [GitHub](https://github.com/palaidn/palaidn-subnet)

# The Palaidn.com Ecosystem

**1. Validators, Miners, and Palaidn Core:**

Validators create and manage fraud detection campaigns. <br><br>
Miners analyze transactions and report fraudulent activities. They are rewarded with TAO tokens for identifying genuine frauds. Palaidn Core serves as the central platform for managing detection campaigns, analyzing reports, and validating miners' findings.

**2. Incentive Mechanism:**
Miners are incentivized with TAO tokens based on the accuracy of their fraud detection reports. This system ensures cost-effective fraud detection for clients while substantially rewarding miners for their contributions.
<br>


# Integration with Bittensor

Palaidn leverages Bittensor’s decentralized network to distribute fraud detection tasks among miners. <br><br>
Initially, Palaidn will focus on demonstrating its fraud detection capabilities within the Bittensor ecosystem, incentivizing participation. <br><br>
This will potentially serve as a powerful tool for ensuring the integrity and security of the Bittensor network. <br><br>
By harnessing the collaborative efforts of the network's participants, Palaidn aims to significantly enhance the security and trustworthiness of Bittensor, establishing a robust foundation for the future growth of both Palaidn and Bittensor.

# The Start

The start of the Palaidn Network will be focus on creating an open-source existing fraud database. This initial phase is crucial as it will enable miners to train their models on real-world data, enhancing the effectiveness of the network's fraud detection capabilities. For the first month, we will run the subnet to grow the list of existing frauds and identify all wallets that have been tainted in the process.

By building this comprehensive fraud database, Palaidn aims to provide a solid foundation for its fraud detection system. Miners will be incentivized to contribute to this database, ensuring a robust and continuously updated resource for the entire network. This campaign will not only demonstrate Palaidn's capabilities but also foster a collaborative effort to enhance the security of the Bittensor ecosystem.

# Real world usage

The data collected and processed by the Palaidn Network will be utilized by PayPangea, one of the fastest growing decentralized wallets. Since its launch in February, PayPangea has amassed **2M** accounts, highlighting its rapid adoption and the trust it has garnered in the crypto community. By integrating Palaidn's fraud detection capabilities, PayPangea aims to enhance the security and reliability of its wallet services, providing its users with unparalleled protection against fraudulent activities.

# Advantages of Palaidn.com

:globe_with_meridians:**Decentralization** <br>
Palaidn emphasizes decentralization by ensuring a broad distribution of miners and validators, enhancing the system's security and trust.

:moneybag:**Cost-Effectiveness** <br>
By operating on low-cost systems and incentivizing miners with TAO tokens, Palaidn offers an economical solution for fraud detection.

:gem:**Accuracy** <br>
The incentive mechanism encourages miners to accurately identify fraudulent activities, enhancing the quality of fraud detection.

:star:**Competition** <br>
Miners are motivated to outperform each other in identifying genuine frauds, ensuring high-quality detection and reporting.

# Income Sources for Validators
:white_check_mark:**Validators can monetize their participation in Palaidn.com Subnet through various avenues, including:** <br>
- offering fraud detection services <br>
- developing applications using the Palaidn.com API <br>
- providing paid API access to others

# Roadmap

**August 2024**
- Subnet launch
- Paypangea integration
- Add user interface for easy address check

**September 2024**
- Integrate Subnet 15 for data acquisition
- Integrate Subnet 13 for data sourcing
- Add more sources of data
- API for wallet and transaction check

**Q4 2024**
- Integrate Subnet 22 for data sourcing
- AI for wallet and transaction scan
- Add AI dependencies scanning for code vulnerabilities

**Q1 2025**
- Free and paid tiers, pay usage with TAO
- Double revenue source for our miner and validators

# How to Mine TAO on Subnet 45
1. Create a Bittensor wallet (coldkey & hotkey).
2. Register your hotkey to Subnet 45.
3. Create a PayPangea account [PayPangea.com](https://paypangea.com) and get API key. Paypangea is a free decentralised wallet that we use for web3 authentication. You will find your API key under Profile settings on the top right corner.
3. Create a Alchemy account [Alchmemy.com](https://www.alchemy.com/) and get API key.
5. Hardware requirements:
- VPS with Ubuntu v.22 or higher
- Python v3.12 or higher
- Open communication ports
- No active Firewall preventing communication between your Miner and Validators.
6. Git clone the Palaidn repo, install the needed packages, and start your Miner’s script.

# Creating a Wallet

Before proceeding, you'll need to create a wallet. A wallet is required for managing your digital assets and interacting with the functionalities provided by this repository.

Detailed instructions on how to create a wallet can be found in the official documentation [here](https://docs.bittensor.com/getting-started/wallets).

Please ensure that you follow the steps outlined in the documentation carefully to set up your wallet correctly.

# Registration in Subnetwork

To fully utilize the functionalities provided by this repository, it is necessary to register within the Palaidn.com Subnetwork (UID 45). 
```bash
btcli subnet register --netuid 45 --wallet.name <name> --wallet.hotkey <name>
```

# Installation Guide

To begin using this repository, the first step is to install Bittensor. Bittensor is a prerequisite for running the scripts and tools provided here. 

You can find detailed installation instructions for Bittensor in the official documentation [here](https://docs.bittensor.com/getting-started/installation).

Please make sure to follow the installation steps carefully to ensure that Bittensor is properly set up on your system before proceeding with any other operations.

If you encounter any issues during the installation process, refer to the troubleshooting section in the Bittensor documentation or reach out to our support team for assistance.

**Prerequisites:**
- Ensure that you have Python 3.12 or a later version installed on your system.
- Run your local Subtensor, instructions on how to install Subtensor locally can be found here: [Subtensor Installation Guide](https://github.com/opentensor/subtensor/blob/main/docs/running-subtensor-locally.md)

```bash
git clone https://github.com/palaidn/palaidn_subnet.git
cd palaidn_subnet
python3 -m pip install -e .
python3 setup.py install_lib
python3 setup.py build
```

Make sure you set up an Alchemy account and PayPangea account. Once you have them set up, run the follwing command from palaidn_subnet directory

```bash
./scripts/init.sh
```

**After registration, you can start the miner script using the following command:**

```bash
python neurons/miner.py --netuid 45 --subtensor.network local --wallet.name <name> --wallet.hotkey <name> --logging.debug
```

**And for running the validator script, use:**

```bash
python neurons/validator.py --netuid 45 --subtensor.network local --wallet.name <name> --wallet.hotkey <name> --logging.debug
```