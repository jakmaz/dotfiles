---
description: Perform a comprehensive code quality audit of the repository
agent: plan
subtask: true
---

Perform a comprehensive code quality audit of the current repository.

You are acting as a senior software engineer conducting a rigorous, critical review. Focus only on actionable improvements.

Do NOT summarize the project. Do NOT provide generic advice.

---

## Scope

Analyze the entire codebase:

- Architecture and structure
- Core logic
- APIs (if present)
- Database layer (if present)
- Frontend/UI (if present)
- Tooling and developer experience

Adapt automatically to the tech stack. Do not assume specific frameworks.

---

## Audit Dimensions

### 1. Architecture & Structure

- Evaluate separation of concerns and module boundaries
- Identify tight coupling and hidden dependencies
- Detect over-engineering or missing structure
- Suggest simpler alternatives

### 2. Code Quality

- Readability, naming, consistency
- Function and module size
- Misused abstractions
- Dead code and duplication

### 3. Runtime & Framework Usage

- Detect incorrect or non-idiomatic usage of the stack
- Identify framework-specific anti-patterns

### 4. Data Layer (if applicable)

- Schema design issues (types, constraints, indexing)
- Inefficient or unsafe queries
- Data integrity risks

### 5. API Design (if applicable)

- Endpoint consistency
- Error handling
- Input validation
- Response shape consistency

### 6. Frontend (if applicable)

- Component structure and reuse
- State management
- Over-abstraction
- Styling consistency

### 7. Reliability & Edge Cases

- Missing error handling
- Fragile assumptions
- Race conditions

### 8. Security (practical)

- Sensitive data exposure
- Unsafe input handling
- Misconfigurations

### 9. Tooling & DX

- Linting/formatting setup
- Scripts and workflows
- Missing safeguards
- Developer friction points

---

## Output Format

### 🔴 Critical Issues

Must be fixed immediately.

### 🟠 Important Improvements

High-impact but not urgent.

### 🟡 Minor Improvements

Low-impact refinements.

### 💡 Strategic Suggestions

Bigger-picture improvements aligned with simplicity and maintainability.

---

## For each issue include

- What is wrong  
- Why it matters  
- Concrete fix (prefer code-level suggestions)

---

## Constraints

- Avoid over-engineering
- Prefer simple, pragmatic fixes
- Assume small-scale or single-developer context unless clearly stated otherwise
- Suggest deletions where appropriate

---

## Final Step

End with:

1. Top 3 highest ROI fixes  
2. One “if you do nothing else, do this” recommendation
