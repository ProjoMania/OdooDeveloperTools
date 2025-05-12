# Odoo Developer Tools

A collection of command-line utilities to simplify Odoo development and server management tasks.

## Features

- **SSH Server Management**
  - Add SSH server configurations
  - List all configured SSH servers
  - Connect to SSH servers with a simple menu

- **Odoo Database Management**
  - List all local Odoo databases with details
  - Show database size, filestore size, and Odoo version
  - Drop databases and their filestores
  - Restore databases from backup files
  - Extend Odoo Enterprise license expiration dates

## Installation

### Automatic Installation

The easiest way to install is to use the provided installation script:

```bash
./install.sh
```

This script will:
1. Check for required dependencies
2. Create necessary directories
3. Install the scripts to `~/bin/odoo-tools`
4. Create shell aliases for easy access
5. Update your SSH configuration

### Manual Installation

If you prefer to install manually:

1. Create the necessary directories:
   ```bash
   mkdir -p ~/bin/odoo-tools
   mkdir -p ~/.ssh/config.d
   ```

2. Copy the scripts to your bin directory:
   ```bash
   cp AddSSHServer ConnectSSHServer ListSSHServers ListOdooDatabases ~/bin/odoo-tools/
   ```

3. Make the scripts executable:
   ```bash
   chmod +x ~/bin/odoo-tools/*
   ```

4. Add the following to your `~/.bashrc` or `~/.zshrc`:
   ```bash
   alias addssh='~/bin/odoo-tools/AddSSHServer'
   alias connectssh='~/bin/odoo-tools/ConnectSSHServer'
   alias listssh='~/bin/odoo-tools/ListSSHServers'
   alias listodb='~/bin/odoo-tools/ListOdooDatabases'
   ```

5. Update your SSH config to include the config.d directory:
   ```bash
   echo "Include ~/.ssh/config.d/*.conf" >> ~/.ssh/config
   ```

## Usage

### SSH Server Management

#### Add a new SSH server
```bash
AddSSHServer
```
Follow the prompts to add a new SSH server configuration.

#### List all SSH servers
```bash
ListSSHServers
```
Displays a table of all configured SSH servers with their details.

#### Connect to an SSH server
```bash
ConnectSSHServer
```
Shows a menu of available servers and connects to your selection.

### Odoo Database Management

#### List all Odoo databases
```bash
ListOdooDatabases
```
Displays a table of all local Odoo databases with their name, owner, version, database size, and filestore size.

#### Drop an Odoo database
```bash
DropOdooDatabase
```
Shows a menu of available databases and allows you to select one to drop, including its filestore.

#### Restore an Odoo database
```bash
RestoreOdooDatabase
```
Restores an Odoo database from a backup file (.zip), with options to:
- Deactivate cron jobs
- Deactivate email servers
- Reset admin credentials

#### Extend Odoo Enterprise license
```bash
ExtendOdooEnterprise
```
Finds all Odoo Enterprise databases and allows you to extend their license expiration date by 20 days.

## Customization

You can customize the tools by editing the configuration variables at the top of each script:

- **SSH Configuration Directory**: Default is `~/.ssh/config.d`
- **Odoo Filestore Directory**: Default is `~/.local/share/Odoo/filestore`
- **PostgreSQL User**: Default is `postgres`

## Requirements

- Bash shell
- SSH client
- PostgreSQL client (for database tools)
- `bc` command (for size calculations)

## License

This project is open source and available under the MIT License.