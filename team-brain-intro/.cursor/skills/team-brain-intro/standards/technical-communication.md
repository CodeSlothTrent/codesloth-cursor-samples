# Technical language and communication

Always-on writing standard for replies this skill gives to humans.

Humans reading agent output get overloaded when answers are long, nested, or padded. Use a concise technical style inspired by **[ASD-STE100](https://www.asd-ste100.org/about_STE.html)** (Simplified Technical English) - the aerospace / defence controlled language for clear maintenance and procedure text. This file is a practical subset for chat replies. It is **not** a claim that every word is from the official STE dictionary.

## Goal

Write so a tired engineer can scan the answer once and act. Prefer fewer words. Prefer one idea at a time. Prefer concrete verbs.

## Rules to apply on every reply

1. **Short sentences.** Aim under ~20 words for instructions. Aim under ~25 words for descriptions. Split long sentences.
2. **One instruction per sentence.** Do not stack steps with “and then”.
3. **Active voice.** Say who does what. Prefer “Open the skill folder” over “The skill folder should be opened”.
4. **Simple verb forms.** Prefer present, past, or future. Avoid stacked helpers (“has been being”, “would have been”).
5. **One meaning per word in context.** Do not reuse a loaded term for a second meaning in the same answer without defining it.
6. **Limit noun stacks.** Avoid long chains like “team brain skill intent classification routing table layer”. Break them with prepositions or short clauses.
7. **No filler.** Cut “basically”, “essentially”, “in order to”, “it is important to note that”, and throat-clearing openers.
8. **Lead with the answer.** Put the direct result or decision first. Put background after, only if needed.
9. **Lists for procedures.** Use numbered steps when the reader must do a sequence. Keep each step one action.
10. **Respect the workflow’s output shape.** If the workflow requires a fixed envelope (for example the structured calculator), keep that shape. Apply these rules to any prose *inside* or *around* that shape.

## When you must be brief

If the topic is large, do this:

1. Give the direct answer in one or two short sentences.
2. Add only the bullets the reader needs next.
3. Point to sources instead of restating whole articles.

Do not dump full reference files into the chat. The reader asked a question - not for the entire tribal cache.

## Official STE pointers

| Resource | URL |
|----------|-----|
| About STE (ASD-STE100) | https://www.asd-ste100.org/about_STE.html |
| ASD overview of Simplified Technical English | https://www.asd-europe.org/standards-specifications/simplified-technical-english/ |
