# Ubuntu Setup Scripts

このリポジトリは、Ubuntu のセットアップを簡単に行うためのスクリプトを集めたものです。各スクリプトは **Docker、Wi-Fi、Python、Tailscale** の設定を自動化します。

---

## **🚀 使用方法**
### **1. Docker のセットアップ**
```bash
bash docker_setup.sh
```

### **2. Wi-Fi (Eduroam) のセットアップ**
```bash
cd eduroam
bash wifi_setup.sh
```

### **3. Python 環境のセットアップ**
```bash
cd setup-python
bash setup.sh
```

### **4. Python のエイリアスを有効化**
Python のエイリアス (`python3 -> python`, `pip3 -> pip`) を有効にするには、以下のコマンドを実行してください。
```bash
source ~/.bashrc
```

### **5. Tailscale のセットアップ**
```bash
bash tailscale_setup.sh
```

---

## **📌 注意点**
- スクリプトを実行する前に `chmod +x` を使用して実行権限を付与してください。
  ```bash
  chmod +x *.sh
  ```
- `source ~/.bashrc` を実行しないと、エイリアス (`python`, `pip`) が適用されない場合があります。
- Wi-Fi の設定 (`wifi_setup.sh`) は `sudo` が必要になることがあります。