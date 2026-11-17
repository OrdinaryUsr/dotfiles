---
description: Review staged changes, create commit message, ask for confirmation before committing
agent: build
model: opencode/gpt-5.2-codex
---

Review the staged changes and create a suitable commit message. Follow these steps:

1. First, examine the git status to see what's staged:
!`git status`

2. Review the staged changes in detail:
!`git diff --staged`

3. If necessary, examine specific changed files to understand the changes better. Use read tools for key files.

4. Look at recent commit history for context:
!`git log --oneline -5`

5. Analyze the changes and create a concise, descriptive commit message that follows conventional commit format. Focus on the 'why' rather than just the 'what'.

6. Present the proposed commit message to the user and ask for confirmation before committing.

7. If user confirms, execute the commit with the proposed message. If not, ask for adjustments.

IMPORTANT: Always ask for user confirmation before actually running 'git commit'. Provide reasoning for your proposed commit message based on the changes observed.

Use the following examples as a reference:

```
feat(domain): add UserSession.process_hints attribute

- Add process_hints field to UserSession domain entity and UserSessionModel
- Add UserSession.add_process_hint method
- Update UserSessionMapper to map and validate process_hints
- Add SQL migration to create user_session.process_hints JSON column
- Cover with unit and integration repository tests
```

```
feat: filter global test practice pages based on user focus_ref

- Filter pages in get_practice endpoint when practice_id matches GLOBAL_TEST_PRACTICE_REF
- Move GLOBAL_TEST_PRACTICE_REF constant to app.globals module for centralized access
- Update imports in user_practice and personal_plan_recommender to use global constant
- Add integration tests for filter_global_test_pages function
```

```
fix: OpenAIAssistant tool call handler logic
```

```
test: fix FakeChatService.send_text_message signature
```
