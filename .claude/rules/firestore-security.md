# Firestore security rules

Security is not optional and not deferred. **Whenever you create a new
collection, you must write the matching Firestore security rules in the same
change.** A collection without rules is a bug.

## Versioned file

- Security rules live in **`firestore.rules`** at the repo root and are
  **committed to git** — never edited only in the Firebase console (console
  edits are lost and unreviewed).
- The file is deployed via `firebase deploy --only firestore:rules` and
  referenced from `firebase.json`.
- Rules changes go through code review like any other code.

## Principles

- **Default deny.** Nothing is readable or writable unless a rule explicitly
  allows it. Start from `allow read, write: if false;`.
- **Data is scoped to its owner.** A family's data is accessible **only to that
  family**: a user can read/write a document only if they belong to the family
  the document belongs to. The same isolation applies to every entity (tasks,
  members, events, …).
- **Least privilege.** Grant the narrowest operation needed
  (`read` vs `get`/`list`, `create`/`update`/`delete` separately) rather than a
  blanket `write`.
- **Validate on write.** Check required fields, types, and that the caller can't
  spoof ownership (e.g. `familyId` on a new doc must match the caller's family).
- Keep the rules structure aligned with the data model: one matcher block per
  collection, mirroring how repositories access it.

## Shape

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Helper: is the signed-in user a member of this family?
    function isFamilyMember(familyId) {
      return request.auth != null
        && exists(/databases/$(database)/documents/families/$(familyId)/members/$(request.auth.uid));
    }

    // A family's tasks are accessible only to that family.
    match /families/{familyId}/tasks/{taskId} {
      allow read: if isFamilyMember(familyId);
      allow create: if isFamilyMember(familyId)
        && request.resource.data.familyId == familyId;
      allow update, delete: if isFamilyMember(familyId);
    }

    // Add a matching block for every new collection. Default deny otherwise.
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
```

## Checklist when adding a collection

1. Add its `match` block in `firestore.rules`.
2. Enforce ownership/family isolation and write validation.
3. Confirm the default-deny catch-all still covers everything else.
4. Commit `firestore.rules` with the feature; deploy the rules.
