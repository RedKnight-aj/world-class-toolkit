# Idea Discovery Agent Skill

## Purpose
Deep research across multiple platforms to find real problems, validate ideas, check competitors, and generate ranked business opportunities.

## Platforms to Scan

### Primary Sources
| Platform | What to Find | Method |
|----------|--------------|--------|
| Reddit | Complaints, frustrations, wishes, "no good tool for" | web_fetch |
| Twitter/X | Pain points, product complaints | web_fetch (trending) |
| Hacker News | Startup problems,frustrations | web_fetch |
| Product Hunt | New product gaps, feedback | web_fetch |
| Indie Hackers | Bootstrapping problems | web_fetch |
| GitHub Issues | Feature requests, bugs | web_fetch |
| Quora | Unanswered questions | web_fetch |

### Search Queries
```
- "can't find a good" + [category]
- "too expensive" + [category]
- "wish there was an app"
- "looking for a tool"
- "does anyone know an app"
- "tired of using"
- "frustrated with"
- "how do I automate"
- "is there a way to"
```

## Process

### Step 1: Problem Discovery (2 hours)
1. Search Reddit for top subreddits
2. Find trending pain points
3. Collect quotes and examples
4. Categorize problems

### Step 2: Competitor Check (1 hour)
1. Google search each problem
2. Check G2, Capterra, AppSumo
3. Analyze existing solutions
4. Find gaps

### Step 3: Idea Generation (1 hour)
1. Generate solution ideas for top problems
2. Score each idea (1-10)
3. Rank top 5 opportunities

### Step 4: Report Generation (30 min)
1. Format findings
2. Include pain points, ideas, scores
3. Add action recommendations

## Scoring System

### Problem Score (1-10)
| Factor | Weight |
|--------|--------|
| Frequency | 25% |
| Emotional Intensity | 20% |
| Solvability | 25% |
| Market Size | 15% |
| Willingness to Pay | 15% |

### Idea Score (1-10)
| Factor | Weight |
|--------|--------|
| Feasibility | 25% |
| Market Size | 25% |
| Competition Level | 15% |
| Uniqueness | 15% |
| Revenue Potential | 20% |

## Report Format

### Telegram Report (Short)
```
🎯 WEEKLY IDEA REPORT - [Date]

🔥 TOP PAIN POINTS:
1. [Problem] - [Source]
2. [Problem] - [Source]
3. [Problem] - [Source]

💡 TOP 5 IDEAS:

#1: [Idea Name] - Score: 9.2/10
   Problem: [Pain point]
   Solution: [Your idea]
   Competition: [None/Low/Medium/High]
   Action: [Build?]

#2: [Idea Name] - Score: 8.5/10
...

📊 Stats:
- Problems: 500+
- Ideas: 25
- Competitors: 40+

Full report: [link]
```

## Categories to Focus

1. **SaaS/Startup** - No-code, scaling, marketing
2. **Developer Tools** - APIs, debugging, deployment
3. **Marketing** - SEO, content, social media
4. **Finance** - Personal finance, investing
5. **Health/Fitness** - Workout, diet
6. **Education** - Learning, courses
7. **Business Ops** - Automation, CRM

## Subreddits Priority
- r/startups
- r/Entrepreneur
- r/SaaS
- r/programming
- r/smallbusiness
- r/productivity
- r/getdisciplined

## Output

Deliver report every Saturday 10 AM IST via Telegram message.

## Notes
- Always verify problems with multiple sources
- Focus on solvable problems
- Prioritize ideas with low competition
- Include specific quotes from users
