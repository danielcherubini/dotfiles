---
name: brainstorming
description: Use before any creative work - creating features, building components, or modifying behavior
---

# Brainstorming

Turn ideas into designs through collaborative dialogue before writing any code.

## Hard Gate

Do NOT write code or invoke implementation skills until design is approved.

## Process

1. Explore context — check files, docs, recent commits
2. Ask clarifying questions — one at a time, prefer multiple choice
3. Propose 2-3 approaches with trade-offs and your recommendation
4. Present design section by section, get approval after each
5. Once approved, present the final spec in full

## After Approval

Once the design is approved by the user, present the complete spec in your response — do NOT write it to disk. The spec stays in the conversation and flows directly into the next step.

Use the `question` tool to ask what happens next:

```
ask({
  questions: [{
    id: "next-step",
    question: "Design approved. What would you like to do next?",
    options: [
      { label: "Run a reviewer" },
      { label: "Create implementation plan" },
      { label: "Save spec for later" },
      { label: "Revise the design" }
    ]
  }]
})
```

If the user chooses "Run a reviewer", THEN:
1. Dispatch the **reviewer subagent** with: "Review type: spec"
2. Present the reviewer's feedback
3. If the reviewer found issues, address them or ask the user how to proceed
4. After review is done (or if user skips), re-ask the question about what to do next

If the user chooses "Create implementation plan", respond:

> "OK then. When you're ready, just say the word and I'll load the **create-plan** skill to turn this spec into an implementation plan."

When the user confirms, load the `create-plan` skill and invoke it — do not start planning on your own. The `create-plan` skill handles the entire planning process.

If the user chooses "Save spec for later", THEN:
1. Write it to `docs/plans/YYYY-MM-DD-<topic>-spec.md`
2. Add the new spec to `docs/plans/README.md` in the appropriate category with status 📋 DRAFT
3. Update the Quick Stats (increment Total Plans and remaining count)

## Principles

- One question per message
- YAGNI — remove unnecessary features
- Design for clear boundaries and single responsibilities
- In existing codebases, follow established patterns
- Scale detail to complexity — a few sentences if simple, more if nuanced