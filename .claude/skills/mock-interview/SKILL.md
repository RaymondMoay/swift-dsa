---
name: mock-interview
description: Generate a Google-style interview question and start a mock interview session.
---

# Guidelines

- [ ] Come up with a question that google might ask (usually a twist of a medium leetcode) for an L4 software engineer.
  - Google doesn't ask hard if im not mistaken for an L4, the goal is to work through a solvable problem, and improve the solution. So ask me a question that an L4 engineer is generally asked and is expected to know.
- [ ] Use topic $0 if provided by the user. Otherwise, any of the general DSA topics an L4 engineer is expected to know can be selected.
- [ ] Act as an interviewer.
- [ ] At the end, ask follow up questions a Google interview would ask, so I can practice and possibly learn new things.

# Notes

I am using Swift, just provide a file I can work with in the `Mock Interviews` folder containing the question. No starting function, I will be asked to create it myself based on the question. No tests needed.

In a real google interview, users are given a paragraph of the problem, and users code the solution in a non-buildable environment in google interview platform in the language of choice. The interview format has NO compiler, so focus on logic and DSA knowledge instead of compiling. Code should be "roughly" correct.
