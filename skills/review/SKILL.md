---
name: review
description: |
  Provides comprehensive code review guidance for React 19, Vue 3, Rust, TypeScript, Java, Python, and C/C++.
  Helps catch bugs, improve code quality, and give constructive feedback.
  Use when: reviewing pull requests, conducting PR reviews, code review, reviewing code changes,
  establishing review standards, mentoring developers, architecture reviews, security audits,
  checking code quality, finding bugs, giving feedback on code.
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash      # Run lint/test/build commands to verify code quality
  - WebFetch  # Look up latest docs and best practices
---

# Koji Review

Transform code reviews from gatekeeping to knowledge sharing through constructive feedback, systematic analysis, and collaborative improvement.

## When to Use This Skill

- Reviewing pull requests and code changes
- Establishing code review standards for teams
- Mentoring junior developers through reviews
- Conducting architecture reviews
- Creating review checklists and guidelines
- Improving team collaboration
- Reducing code review cycle time
- Maintaining code quality standards

## Core Principles

### 1. The Review Mindset

**Goals of Code Review:**
- Catch bugs and edge cases
- Ensure code maintainability
- Share knowledge across team
- Enforce coding standards
- Improve design and architecture
- Build team culture

**Not the Goals:**
- Show off knowledge
- Nitpick formatting (use linters)
- Block progress unnecessarily
- Rewrite to your preference

### 2. Effective Feedback

**Good Feedback is:**
- Specific and actionable
- Educational, not judgmental
- Focused on the code, not the person
- Balanced (praise good work too)
- Prioritized (critical vs nice-to-have)

```markdown
❌ Bad: "This is wrong."
✅ Good: "This could cause a race condition when multiple users
         access simultaneously. Consider using a mutex here."

❌ Bad: "Why didn't you use X pattern?"
✅ Good: "Have you considered the Repository pattern? It would
         make this easier to test. Here's an example: [link]"

❌ Bad: "Rename this variable."
✅ Good: "[nit] Consider `userCount` instead of `uc` for
         clarity. Not blocking if you prefer to keep it."
```

### 3. Review Scope

**What to Review:**
- Logic correctness and edge cases
- Security vulnerabilities
- Performance implications
- Test coverage and quality
- Error handling
- Documentation and comments
- API design and naming
- Architectural fit

**What Not to Review Manually:**
- Code formatting (use Prettier, Black, etc.)
- Import organization
- Linting violations
- Simple typos

## Review Process

### Phase 1: Context Gathering (2-3 minutes)

Before diving into code, understand:
1. Read PR description and linked issue
2. Check PR size (>400 lines? Ask to split)
3. Review CI/CD status (tests passing?)
4. Understand the business requirement
5. Note any relevant architectural decisions

### Phase 2: High-Level Review (5-10 minutes)

1. **Architecture & Design** - Does the solution fit the problem?
   - For significant changes, consult [Architecture Review Guide](guides/guide-architecture-review.md)
   - Check: SOLID principles, coupling/cohesion, anti-patterns
2. **Performance Assessment** - Are there performance concerns?
   - For performance-critical code, consult [Performance Review Guide](guides/guide-performance-review.md)
   - Check: Algorithm complexity, N+1 queries, memory usage
3. **File Organization** - Are new files in the right places?
4. **Testing Strategy** - Are there tests covering edge cases?

### Phase 3: Line-by-Line Review (10-20 minutes)

For each file, check:
- **Logic & Correctness** - Edge cases, off-by-one, null checks, race conditions
- **Security** - Input validation, injection risks, XSS, sensitive data
- **Performance** - N+1 queries, unnecessary loops, memory leaks
- **Maintainability** - Clear names, single responsibility, comments

### Phase 4: PRESENT FINDINGS AND ASK WHAT TO FIX (REQUIRED — HARD STOP)

> 🛑 **HARD STOP POINT — READ THIS FIRST**
>
> This is the **ONLY** place in the entire review process where you must pause and wait for user input. After presenting findings, your job is DONE until the user responds.
>
> **EXECUTION FLOW (MUST follow this exact sequence):**
> ```
> Phase 3 (Line-by-line review) → Present Summary → call ask() → [STOP — WAIT] → (user responds) → Phase 5
>                                                              ↑
>                                                              └── YOU MUST STOP HERE. NOTHING ELSE.
> ```
>
> **PRE-FLIGHT CHECKLIST (Complete ALL before proceeding):**
> - [ ] I have presented the summary of findings ✅
> - [ ] I have called `ask()` with the fix-priority question ✅
> - [ ] I am NOT about to fix, suggest, or modify any code ✅
> - [ ] I am waiting for user input before doing anything else ✅
>
> **❌ NEVER do any of these:**
> - Present findings and then immediately start fixing issues
> - Say "What would you like to do?" in plain text instead of using `ask()`
> - Begin Phase 5 fixes before receiving a response from `ask()`
> - Assume the user wants everything fixed — let them choose
> - Continue reading code after presenting findings
> - Suggest fixes without waiting for user selection
>
> **✅ ALWAYS do this — IN EXACT ORDER:**
> 1. Present the summary (count and categorize all findings)
> 2. Call `ask()` with the exact question format shown below
> 3. STOP. Wait for the user's response.
>
> **This is a hard break in your execution flow.** You must not proceed to Phase 5 until `ask()` returns with a user answer.
>
> **VIOLATION DETECTION:** If you find yourself about to fix, suggest, or modify code after presenting findings, you have violated this rule. Go back and call `ask()` first.

#### Step 1: Count and categorize all findings

```typescript
// Tally your findings:
let countBlocking = 0;    // 🔴 Must fix before merge
let countImportant = 0;   // 🟡 Should fix, discuss if disagree
let countNit = 0;         // 🟢 Nice to have, not blocking
let countSuggestions = 0; // 💡 Alternative approaches
```

#### Step 2: Present a summary of findings FIRST

```markdown
## Code Review Summary

**🔴 Blocking (N):**
1. [Issue description] - `file.ts:42`
2. ...

**🟡 Important (N):**
1. [Issue description] - `file.ts:100`
2. ...

**🟢 Nit (N):**
1. ...

**💡 Suggestions (N):**
1. ...
```

#### Step 3: CALL ask() IMMEDIATELY after the summary

```typescript
ask({
  questions: [{
    id: "fix-priority",
    question: `Found ${countBlocking + countImportant + countNit + countSuggestions} issues. What would you like to fix?`,
    options: [
      { label: `Fix 🔴 blocking only (${countBlocking})` },
      { label: `Fix 🔴 + 🟡 (${countBlocking + countImportant})` },
      { label: `Fix all (blocking + important + nit)` },
      { label: `Review all findings without fixing` }
    ],
    description: `**🔴 Blocking:** Must fix before merge\n**🟡 Important:** Should fix, discuss if disagree\n**🟢 Nit:** Nice to have, not blocking\n**💡 Suggestions:** Alternative approaches`
  }]
})
```

#### Step 4: STOP and WAIT for user response

After calling `ask()`, your review is complete. Do nothing else. Do not start fixing. Do not suggest fixes. Wait for the user to respond, then proceed to Phase 5 based on their answer.

**If you skip this step or bypass ask(), you have violated a core rule of the review process.**

### Phase 5: Fix Issues (Based on User Choice)

**⚠️ You may ONLY enter this phase after `ask()` has returned a user response.** If you are here without having called `ask()` first, you have made an error — go back to Phase 4.

Fix issues ONE AT A TIME based on user's selection. For each issue:
1. Explain the problem clearly
2. Show the fix
3. Verify with tests/linting
4. Move to next issue

## Review Techniques

### Technique 1: The Checklist Method

Use checklists for consistent reviews. See [Security Review Guide](guides/guide-security-review.md) for comprehensive security checklist.

### Technique 2: The Question Approach

Instead of stating problems, ask questions:

```markdown
❌ "This will fail if the list is empty."
✅ "What happens if `items` is an empty array?"

❌ "You need error handling here."
✅ "How should this behave if the API call fails?"
```

### Technique 3: Suggest, Don't Command

Use collaborative language:

```markdown
❌ "You must change this to use async/await"
✅ "Suggestion: async/await might make this more readable. What do you think?"

❌ "Extract this into a function"
✅ "This logic appears in 3 places. Would it make sense to extract it?"
```

### Technique 4: Differentiate Severity

Use labels to indicate priority:

- 🔴 `[blocking]` - Must fix before merge
- 🟡 `[important]` - Should fix, discuss if disagree
- 🟢 `[nit]` - Nice to have, not blocking
- 💡 `[suggestion]` - Alternative approach to consider
- 📚 `[learning]` - Educational comment, no action needed
- 🎉 `[praise]` - Good work, keep it up!

## Language-Specific Guides

When reviewing code in a specific language/framework, consult the corresponding detailed guide:

| Language/Framework | Reference File | Key Topics |
|-------------------|----------------|------------|
| **React** | [React Guide](languages/lang-react.md) | Hooks, useEffect, React 19 Actions, RSC, Suspense, TanStack Query v5 |
| **Vue 3** | [Vue Guide](languages/lang-vue.md) | Composition API, Reactivity System, Props/Emits, Watchers, Composables |
| **Rust** | [Rust Guide](languages/lang-rust.md) | Ownership/Borrowing, Unsafe Review, Async Code, Error Handling |
| **TypeScript** | [TypeScript Guide](languages/lang-typescript.md) | Type Safety, async/await, Immutability |
| **Python** | [Python Guide](languages/lang-python.md) | Mutable Default Args, Exception Handling, Class Attributes |
| **Java** | [Java Guide](languages/lang-java.md) | Java 21/25 Features, Spring Boot 4, Virtual Threads, Stream/Optional |
| **Go** | [Go Guide](languages/lang-go.md) | Error Handling, goroutine/channel, context, Interface Design |
| **C** | [C Guide](languages/lang-c.md) | Pointers/Buffers, Memory Safety, UB, Error Handling |
| **C++** | [C++ Guide](languages/lang-cpp.md) | RAII, Lifetime, Rule of 0/3/5, Exception Safety |
| **SQL/PostgreSQL** | [SQL/PG Guide](languages/lang-sql-pg.md) | SQL Injection Prevention, EXPLAIN ANALYZE, Indexing, Concurrency |
| **CSS/Less/Sass** | [CSS Guide](languages/lang-css-less-sass.md) | Variable Conventions, !important, Performance Optimization, Responsive Design |
| **Qt** | [Qt Guide](languages/lang-qt.md) | Object Model, Signals/Slots, Memory Management, Thread Safety |

## Additional Resources

- [Architecture Review Guide](guides/guide-architecture-review.md) - Architecture design review guide (SOLID, anti-patterns, coupling)
- [Performance Review Guide](guides/guide-performance-review.md) - Performance review guide (Web Vitals, N+1, complexity)
- [Common Bugs Checklist](checklists/checklist-common-bugs.md) - Common bugs by language
- [Security Review Guide](guides/guide-security-review.md) - Security review guide
- [Code Review Best Practices](guides/guide-code-review-best-practices.md) - Code review best practices
