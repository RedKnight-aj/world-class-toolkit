#!/bin/bash

# =============================================================================
# RedKnight Elite - Setup Script
# =============================================================================
# This script automates the setup of the RedKnight AI Agentic System
# 
# Usage: bash setup.sh
# 
# Requirements:
#   - Node.js 18+
#   - npm
#   - Git
# =============================================================================

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://github.com/RedKnight-aj/RedKnight-Elite-Workspace.git"
WORKSPACE_DIR="$HOME/.openclaw/workspace"

# =============================================================================
# Helper Functions
# =============================================================================

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

confirm() {
    read -p "$1 [y/N]: " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# =============================================================================
# Pre-flight Checks
# =============================================================================

check_requirements() {
    log_info "Checking requirements..."
    
    # Check Node.js
    if ! command -v node &> /dev/null; then
        log_error "Node.js is not installed. Please install Node.js 18+ first."
        exit 1
    fi
    
    NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$NODE_VERSION" -lt 18 ]; then
        log_error "Node.js version must be 18 or higher. Current: $(node -v)"
        exit 1
    fi
    
    # Check npm
    if ! command -v npm &> /dev/null; then
        log_error "npm is not installed. Please install npm first."
        exit 1
    fi
    
    # Check Git
    if ! command -v git &> /dev/null; then
        log_error "Git is not installed. Please install Git first."
        exit 1
    fi
    
    log_success "All requirements met!"
}

# =============================================================================
# Step 1: Install OpenClaw
# =============================================================================

install_openclaw() {
    log_info "Installing OpenClaw..."
    
    if command -v openclaw &> /dev/null; then
        log_warn "OpenClaw is already installed. Skipping installation."
        return 0
    fi
    
    npm install -g openclaw
    
    if command -v openclaw &> /dev/null; then
        log_success "OpenClaw installed successfully!"
    else
        log_error "Failed to install OpenClaw."
        exit 1
    fi
}

# =============================================================================
# Step 2: Setup Gateway
# =============================================================================

setup_gateway() {
    log_info "Setting up OpenClaw Gateway..."
    
    # Check if gateway is already running
    if openclaw gateway status &> /dev/null; then
        log_warn "Gateway is already running. Skipping setup."
        return 0
    fi
    
    # Start the gateway
    openclaw gateway start
    
    # Wait for gateway to be ready
    log_info "Waiting for gateway to be ready..."
    sleep 5
    
    # Verify gateway is running
    if openclaw gateway status &> /dev/null; then
        log_success "Gateway is running!"
    else
        log_error "Failed to start gateway."
        exit 1
    fi
}

# =============================================================================
# Step 3: Configure Channels
# =============================================================================

configure_channels() {
    log_info "Configuring channels..."
    
    log_warn "Channel configuration requires manual setup."
    log_info "Please run the following commands:"
    echo ""
    echo "  1. Configure Telegram:"
    echo "     openclaw configure --channel telegram"
    echo ""
    echo "  2. Configure Slack:"
    echo "     openclaw configure --channel slack"
    echo ""
    echo "  Note: You will need bot tokens from respective platforms."
    
    if confirm "Have you configured the channels?"; then
        log_success "Channels configured!"
    else
        log_warn "Please configure channels before continuing."
    fi
}

# =============================================================================
# Step 4: Clone Workspace
# =============================================================================

clone_workspace() {
    log_info "Cloning workspace repository..."
    
    # Check if workspace already exists
    if [ -d "$WORKSPACE_DIR" ]; then
        log_warn "Workspace directory already exists. Updating..."
        cd "$WORKSPACE_DIR"
        git pull origin master
    else
        # Clone the repository
        mkdir -p "$(dirname "$WORKSPACE_DIR")"
        git clone "$REPO_URL" "$WORKSPACE_DIR"
    fi
    
    log_success "Workspace ready at $WORKSPACE_DIR"
}

# =============================================================================
# Step 5: Create Cron Jobs
# =============================================================================

create_cron_jobs() {
    log_info "Creating cron jobs..."
    
    # Cron Job 1: AI News Digest (Every 3 hours)
    log_info "Creating AI News Digest cron job..."
    openclaw cron add \
        --name "AI News Digest" \
        --every 3h \
        --tz "UTC" \
        --session isolated \
        --agent researcher \
        --model minimax-portal/MiniMax-M2.5 \
        --thinking medium \
        --message "Research latest AI news from the last 3 hours.

FOCUS: Important, impactful AI news from reputable sources.

PRIORITY SOURCES:
1. GitHub Trending (AI projects, releases)
2. TechCrunch AI section
3. VentureBeat AI
4. NVIDIA/Google/Microsoft/OpenAI official blogs
5. arXiv latest papers (for breakthroughs)

CONTENT RULES:
✅ Include:
- Major AI product releases
- Significant research breakthroughs
- Major funding/acquisitions
- Important AI policy/regulation news
- Technical innovations that matter

❌ Exclude:
- Generic AI opinions
- Minor tool updates
- Unverified claims
- Marketing fluff

FORMAT (Slack-native, mobile-optimized):

🤖 AI NEWS DIGEST — [Date] — [Time] IST

*📋 TOP NEWS*
[3-5 most important stories with source links]

*💡 KEY INSIGHT*
[One sentence on the biggest trend]

*🔬 RESEARCH SPOTLIGHT*
[If any significant papers/releases]

*🛠️ TOOLS & RELEASES*
[New tools, models, platforms]

*📚 RESOURCES*
[Key links]

—
_Curated by RedKnight | AI News_

IMPORTANT: When sending to Slack #news (C08T2RF302G):
- channel: slack
- target: C08T2RF302G

Use web_fetch ONLY - no web_search." \
        --no-deliver
    
    # Cron Job 2: AI Testing Daily (10:30 AM IST)
    log_info "Creating AI Testing Daily cron job..."
    openclaw cron add \
        --name "AI Testing Daily" \
        --cron "30 10 * * *" \
        --tz "Asia/Kolkata" \
        --session isolated \
        --agent researcher \
        --model minimax-portal/MiniMax-M2.5 \
        --thinking medium \
        --message "Research and prepare AI testing content for the team. 

FOCUS: Internal Team Learning - Build AI testing expertise progressively.

CONTENT ROTATION BY DAY:
- Monday: Tool of the Week
- Tuesday: Benchmark Updates
- Wednesday: Methodology  
- Thursday: Real-World Cases
- Friday: Practice Lab

IMPORTANT: When sending the message to Slack, use:
- action: send
- channel: slack
- target: C08T1LAK658
- message: [the formatted content with time in header]

The message should include the current date and time in IST in the header format like:
🧪 AI TESTING DAILY — Monday — February 22, 2026 — 10:30 AM IST

Use web_fetch ONLY - no web_search." \
        --no-deliver
    
    # Cron Job 3: AI Security Testing Daily (10:30 AM IST)
    log_info "Creating AI Security Testing Daily cron job..."
    openclaw cron add \
        --name "AI Security Testing Daily" \
        --cron "30 10 * * *" \
        --tz "Asia/Kolkata" \
        --session isolated \
        --agent researcher \
        --model minimax-portal/MiniMax-M2.5 \
        --thinking medium \
        --message "Research and prepare AI security testing content for the team.

FOCUS: AI Security Testing - Vulnerabilities, defense, compliance, audits.

CONTENT ROTATION BY DAY:
- Monday: Tool of the Week
- Tuesday: Vulnerability Watch
- Wednesday: OWASP & Standards
- Thursday: Real Incidents
- Friday: Practice Lab

IMPORTANT: When sending the message to Slack, use:
- action: send
- channel: slack
- target: C0AGCQFHTTN
- message: [the formatted content with time in header]

The message should include the current date and time in IST in the header format like:
🛡️ AI SECURITY DAILY — Monday — February 22, 2026 — 10:30 AM IST

Use web_fetch ONLY - no web_search." \
        --no-deliver
    
    log_success "All cron jobs created!"
}

# =============================================================================
# Step 6: Verify Setup
# =============================================================================

verify_setup() {
    log_info "Verifying setup..."
    
    echo ""
    echo "========================================"
    echo "       SETUP VERIFICATION"
    echo "========================================"
    echo ""
    
    # Check OpenClaw
    echo -n "OpenClaw CLI: "
    if command -v openclaw &> /dev/null; then
        echo -e "${GREEN}✓ Installed${NC}"
    else
        echo -e "${RED}✗ Not installed${NC}"
    fi
    
    # Check Gateway
    echo -n "Gateway: "
    if openclaw gateway status &> /dev/null; then
        echo -e "${GREEN}✓ Running${NC}"
    else
        echo -e "${RED}✗ Not running${NC}"
    fi
    
    # Check Cron Jobs
    echo -n "Cron Jobs: "
    JOB_COUNT=$(openclaw cron list 2>/dev/null | grep -c "cron" || echo "0")
    if [ "$JOB_COUNT" -gt 0 ]; then
        echo -e "${GREEN}✓ $JOB_COUNT jobs configured${NC}"
    else
        echo -e "${RED}✗ No jobs configured${NC}"
    fi
    
    # Check Workspace
    echo -n "Workspace: "
    if [ -d "$WORKSPACE_DIR" ]; then
        echo -e "${GREEN}✓ Cloned${NC}"
    else
        echo -e "${RED}✗ Not found${NC}"
    fi
    
    echo ""
    echo "========================================"
    echo ""
    
    # List cron jobs
    log_info "Active Cron Jobs:"
    openclaw cron list
}

# =============================================================================
# Main
# =============================================================================

main() {
    echo ""
    echo "========================================"
    echo "   RedKnight Elite - Setup Script"
    echo "========================================"
    echo ""
    
    check_requirements
    install_openclaw
    setup_gateway
    
    if confirm "Do you want to clone the workspace?"; then
        clone_workspace
    fi
    
    if confirm "Do you want to create cron jobs?"; then
        create_cron_jobs
    fi
    
    verify_setup
    
    echo ""
    log_success "Setup complete!"
    echo ""
    echo "Next steps:"
    echo "  1. Configure channels: openclaw configure"
    echo "  2. Update Slack channel IDs in cron jobs if needed"
    echo "  3. Set up API keys in TOOLS.md"
    echo ""
}

# Run main function
main "$@"
