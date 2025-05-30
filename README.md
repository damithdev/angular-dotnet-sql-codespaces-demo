# 🚀 angular-dotnet-sql-codespaces-demo

This Codespaces-enabled project provides a full-stack development environment with **Angular**, **.NET 8 Web API**, and a browser-based SQL client (**SQLPad**) that connects to your **Azure SQL Database** — all preconfigured with Docker and GitHub Codespaces.

---

### 📦 Tech Stack

- **Frontend**: Angular  
- **Backend**: .NET 8 Web API  
- **Database**: Azure SQL Database  
- **Dev Tool**: SQLPad (v7.5.3)  
- **Environment**: GitHub Codespaces + Docker  

---

## 🛠️ Getting Started

### 1. 🚨 Configure Required GitHub Secrets

Before launching your Codespace, make sure to define the following **GitHub repository secrets** under  
**Settings → Secrets and variables → Actions → New repository secret**:

| Secret Name              | Description                        |
|--------------------------|------------------------------------|
| `AZ_SQL_SERVER`          | SQL Server hostname (e.g. `your-server.database.windows.net`) |
| `AZ_SQL_DATABASE`        | Target database name               |
| `AZ_SQL_USERNAME`        | SQL login username                 |
| `AZ_SQL_PASSWORD`        | SQL login password                 |
| `SQLPAD_ADMIN_EMAIL`     | Email for SQLPad admin login       |
| `SQLPAD_ADMIN_PASSWORD`  | Password for SQLPad admin login    |

> These secrets are injected into the Codespace environment for SQLPad connection setup.

---

### 2. 🚀 Open in GitHub Codespaces

Click the green **"Code"** button, then choose **"Codespaces" → "Create Codespace"**.

Alternatively, press the **`.`** key on your keyboard from the repo page.

---

### 3. ▶️ Start SQLPad

Once your Codespace boots up, run this command in the terminal to launch SQLPad manually:

```bash
.devcontainer/start-sqlpad.sh
```
---

### 4. 🖥️ Start the Backend API (ASP.NET Core)

From the `backend/api` folder, run:

```bash
dotnet run --project backend/api
```

### 5. 🖥️ Start the Angular Frontend

From the `frontend` folder, run:

```bash
npm start --prefix frontend
```

---

### ✅ What This Does

Running `.devcontainer/start-sqlpad.sh` will:

- 🚀 Launch **SQLPad** with your environment-configured credentials  
- 🔌 Automatically create a **default connection** to your **Azure SQL Database**  
- 🌐 Expose SQLPad on **port 3000** — accessible via `http://localhost:3000`  

---

### 📝 Notes

- **SQLPad version**: `7.5.3` (manually pulled and built from source)
- The **default connection** is created using SQLPad's REST API via `start-sqlpad.sh`
- ⚠️ **Manual start required**: SQLPad is **not auto-launched** via `postStartCommand` due to GitHub Codespaces limitations

---

### 🌐 Port Forwarding

The following ports are automatically forwarded in GitHub Codespaces:

| Port | Service          |
|------|------------------|
| 4200 | Angular frontend |
| 5000 | .NET Web API     |
| 3000 | SQLPad UI        |

---

### 🧪 Troubleshooting

#### 🔐 Missing or Incorrect Secrets?

Update the secret(s) in **GitHub → Repository → Settings → Secrets**,  
then **rebuild** the Codespace.

---

#### 🔄 Restarting SQLPad?

```bash
.devcontainer/start-sqlpad.sh
```

### 📄 View SQLPad Logs

To view real-time logs from SQLPad:

```bash
tail -f /workspaces/sqlpad-data/sqlpad.log
```