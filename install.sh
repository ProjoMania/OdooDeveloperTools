#!/bin/bash

# === Colors ===
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# === Settings ===
INSTALL_DIR="$HOME/.local/bin/OdooDeveloperTools"
CONFIG_DIR="$HOME/.ssh/config.d"
FILESTORE_DIR="$HOME/.local/share/Odoo/filestore"

# === Functions ===
check_dependencies() {
    echo -e "${BLUE}Checking dependencies...${NC}"
    
    # Check for PostgreSQL client
    if ! command -v psql &> /dev/null; then
        echo -e "${YELLOW}⚠️ PostgreSQL client not found. Some database tools may not work properly.${NC}"
        echo -e "   To install PostgreSQL client: sudo apt-get install postgresql-client"
    else
        echo -e "${GREEN}✓ PostgreSQL client found${NC}"
    fi
    
    # Check for SSH
    if ! command -v ssh &> /dev/null; then
        echo -e "${YELLOW}⚠️ SSH client not found. SSH tools may not work properly.${NC}"
        echo -e "   To install SSH client: sudo apt-get install openssh-client"
    else
        echo -e "${GREEN}✓ SSH client found${NC}"
    fi
    
    # Check for bc (used for calculations)
    if ! command -v bc &> /dev/null; then
        echo -e "${YELLOW}⚠️ 'bc' command not found. Some calculations may not work properly.${NC}"
        echo -e "   To install bc: sudo apt-get install bc"
    else
        echo -e "${GREEN}✓ bc found${NC}"
    fi
}

create_directories() {
    echo -e "${BLUE}Creating necessary directories...${NC}"
    
    # Create installation directory
    mkdir -p "$INSTALL_DIR"
    echo -e "${GREEN}✓ Created $INSTALL_DIR${NC}"
    
    # Create SSH config directory if it doesn't exist
    mkdir -p "$CONFIG_DIR"
    echo -e "${GREEN}✓ Created $CONFIG_DIR${NC}"
    
    # Create filestore directory if it doesn't exist
    mkdir -p "$FILESTORE_DIR"
    echo -e "${GREEN}✓ Created $FILESTORE_DIR${NC}"
    
    # Create ~/.local/bin if it doesn't exist
    mkdir -p "$HOME/.local/bin"
    echo -e "${GREEN}✓ Created $HOME/.local/bin${NC}"
}

install_scripts() {
    echo -e "${BLUE}Installing Odoo Developer Tools...${NC}"
    
    # Copy scripts to installation directory
    echo -e "${BLUE}Copying scripts to $INSTALL_DIR...${NC}"
    cp AddSSHServer "$INSTALL_DIR/"
    echo -e "${GREEN}✓ Copied AddSSHServer${NC}"
    
    cp ConnectSSHServer "$INSTALL_DIR/"
    echo -e "${GREEN}✓ Copied ConnectSSHServer${NC}"
    
    cp ListSSHServers "$INSTALL_DIR/"
    echo -e "${GREEN}✓ Copied ListSSHServers${NC}"
    
    cp ListOdooDatabases "$INSTALL_DIR/"
    echo -e "${GREEN}✓ Copied ListOdooDatabases${NC}"
    
    cp DropOdooDatabase "$INSTALL_DIR/"
    echo -e "${GREEN}✓ Copied DropOdooDatabase${NC}"
    
    # Make scripts executable
    echo -e "${BLUE}Adding execute permissions...${NC}"
    chmod u+x "$INSTALL_DIR"/*
    echo -e "${GREEN}✓ Added execute permissions to all scripts${NC}"
    
    echo -e "${GREEN}✓ Successfully installed scripts to $INSTALL_DIR${NC}"
}

update_path() {
    echo -e "${BLUE}Updating PATH in ~/.bashrc...${NC}"
    
    # Check if .bashrc exists
    if [[ ! -f "$HOME/.bashrc" ]]; then
        echo -e "${YELLOW}⚠️ Could not find .bashrc. Creating it...${NC}"
        touch "$HOME/.bashrc"
    fi
    
    # Add the directory to PATH if it doesn't already exist in .bashrc
    if ! grep -q "export PATH=\"$HOME/.local/bin/OdooDeveloperTools:\$PATH\"" "$HOME/.bashrc"; then
        echo -e "\n# Added by Odoo Developer Tools installer" >> "$HOME/.bashrc"
        echo "export PATH=\"$HOME/.local/bin/OdooDeveloperTools:\$PATH\"" >> "$HOME/.bashrc"
        echo -e "${GREEN}✓ Added $INSTALL_DIR to PATH in ~/.bashrc${NC}"
    else
        echo -e "${GREEN}✓ $INSTALL_DIR is already in PATH${NC}"
    fi
    
    echo -e "${YELLOW}Note: You'll need to restart your terminal or run 'source ~/.bashrc' to update your PATH${NC}"
}

update_ssh_config() {
    echo -e "${BLUE}Updating SSH configuration...${NC}"
    
    SSH_CONFIG="$HOME/.ssh/config"
    
    # Create SSH config file if it doesn't exist
    if [[ ! -f "$SSH_CONFIG" ]]; then
        touch "$SSH_CONFIG"
    fi
    
    # Add Include directive if it doesn't exist
    if ! grep -q "Include $CONFIG_DIR/\*.conf" "$SSH_CONFIG"; then
        echo -e "\n# Include Odoo Developer Tools SSH configurations" >> "$SSH_CONFIG"
        echo "Include $CONFIG_DIR/*.conf" >> "$SSH_CONFIG"
        echo -e "${GREEN}✓ Updated SSH config to include configurations from $CONFIG_DIR${NC}"
    else
        echo -e "${GREEN}✓ SSH config already includes configurations from $CONFIG_DIR${NC}"
    fi
}

# === Main ===
echo -e "${BLUE}==================================================${NC}"
echo -e "${BLUE}    Odoo Developer Tools - Installation Script    ${NC}"
echo -e "${BLUE}==================================================${NC}"

# Run installation steps
echo -e "${BLUE}Step 1/5: Checking dependencies...${NC}"
check_dependencies
echo

echo -e "${BLUE}Step 2/5: Creating directories...${NC}"
create_directories
echo

echo -e "${BLUE}Step 3/5: Installing scripts...${NC}"
install_scripts
echo

echo -e "${BLUE}Step 4/5: Updating PATH...${NC}"
update_path
echo

echo -e "${BLUE}Step 5/5: Updating SSH configuration...${NC}"
update_ssh_config
echo

echo -e "${BLUE}==================================================${NC}"
echo -e "${GREEN}✅ Installation complete!${NC}"
echo -e "${YELLOW}Available commands (after restarting terminal or sourcing ~/.bashrc):${NC}"
echo -e "  ${GREEN}AddSSHServer${NC}      - Add a new SSH server configuration"
echo -e "  ${GREEN}ConnectSSHServer${NC}  - Connect to a configured SSH server"
echo -e "  ${GREEN}ListSSHServers${NC}    - List all configured SSH servers"
echo -e "  ${GREEN}ListOdooDatabases${NC} - List all local Odoo databases"
echo -e "  ${GREEN}DropOdooDatabase${NC}  - Remove an Odoo database and its filestore"
echo -e "${BLUE}==================================================${NC}"
echo -e "${YELLOW}To start using the tools, run: source ~/.bashrc${NC}"
echo -e "${BLUE}==================================================${NC}"
