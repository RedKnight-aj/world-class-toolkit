#

 PrimusPost Skill## Overview
This skill provides context and commands for working with PrimusPost - a social media management platform built with Next.js 16.

## Project Structure

```
primuspost/
├── app/                    # Next.js App Router pages
│   ├── api/               # API routes
│   │   ├── carousel/      # Carousel generation
│   │   ├── content/       # Content management
│   │   ├── orchestrate/   # AI orchestration
│   │   ├── posts/         # Post management
│   │   ├── user/          # User management
│   │   └── voice/         # Voice generation
│   ├── overview/          # Dashboard
│   ├── repurpose/         # Content repurposing
│   ├── studio/            # Content studio
│   ├── library/           # Content library
│   └── settings/          # User settings
├── lib/                   # Core services
│   ├── services/          # Business logic
│   │   ├── voice.service.ts
│   │   ├── content.service.ts
│   │   ├── repurpose.service.ts
│   │   ├── carousel.service.ts
│   │   ├── orchestration.service.ts
│   │   └── subscription.service.ts
│   ├── repositories/      # Data access
│   │   └── gemini.repository.ts
│   └── validation/        # Zod schemas
└── components/            # React components
```

## Key Technologies
- **Framework**: Next.js 16
- **Auth**: Clerk
- **AI**: Google Gemini
- **Database**: PostgreSQL + Drizzle ORM
- **UI**: Radix UI + Tailwind CSS
- **Rich Text**: TipTap

## Commands

### Analyze Project
Analyze the PrimusPost project structure and identify areas for improvement.

### Add Feature
Add a new feature to PrimusPost. Requires:
- Feature specification
- API route if needed
- Service logic
- Frontend component

### Fix Bug
Fix a bug in PrimusPost. Requires:
- Bug description
- Error logs if available

### Improve Performance
Optimize PrimusPost for better performance.

### Add Test
Add tests for existing functionality.

## Working Directory
Always work in: `/home/aj979515/.openclaw/workspace/primuspost`

## Common npm Commands
```bash
npm run dev      # Development server
npm run build    # Production build
npm run start    # Production server
npm run lint     # ESLint
npm run test     # Run tests
```

## Environment Variables
Check `.env` for required variables:
- CLERK_SECRET_KEY
- DATABASE_URL
- GEMINI_API_KEY
- NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY

## Notes
- Uses TypeScript throughout
- Follows Next.js App Router conventions
- Services are singleton via ServiceRegistry
- AI is powered by Gemini repository
