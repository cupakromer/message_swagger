# 20220310151922. Record architecture decisions

Date: 2022-03-10

## Status

Accepted

## Context

We need to record the architectural decisions made on this project.

## Decision

We will use Architecture Decision Records, as [described by Michael Nygard][1]. A few adjustments to
the basic template are made:

- To support distributed teams, ADR numbers will use a `YYYYmmddHHMMSS` format

  Usage of this format helps reduce collisions between multiple people creating ADRs around the same
  time. This specific format is already widely used by Rails for generating database migrations.

  One alternative considered was using the Unix epoch seconds. While that number is less human
  comprehensible it is slightly shorter by 4 characters. Since Rails migrations already employ this
  timestamp format we are going with it to be consistent.
- A new template is used which includes sections pulled from the [Stitch Fix][4] blog post, as well
  as, several open source [templates compiled by Joel Parker Henderson][5].

  Some sections in the template are optional and there are temporary comments to help guide people
  on filling out the sections

## Consequences

Benefits of using ADRs are well documented by organizations such as [Github][2], [18F][3] and
[Stitch Fix][4]. In short, they provide a view of decision as a snapshot in time. ADRs are similar to
RFCs in this respect, as they can be superseded and updated (by a new ADR) over time. Using ADRs is
a good gateway into larger summary documentation, especially for small teams whom feel they may not
have the time to devote to constantly keeping summary docs up-to-date.

ADRs also provide a central location to get a lot of context related to decisions co-located with
the code. A lot of this information can, and should also, live in git commit messages. However,
overtime those commit message can be several hops away from the related code. That makes it hard to
find the information when necessary. Similarly, PRs seem to have an equally sneaky habit of being
difficult to discover (not to mention requiring active internet connections) just when you need to
reference them.

For a lightweight ADR toolset, see Nat Pryce's [adr-tools](https://github.com/npryce/adr-tools).


[1]: http://thinkrelevance.com/blog/2011/11/15/documenting-architecture-decisions
[2]: https://github.blog/2020-08-13-why-write-adrs/
[3]: https://18f.gsa.gov/2021/07/06/architecture_decision_records_helpful_now_invaluable_later/
[4]: https://multithreaded.stitchfix.com/blog/2020/12/07/remote-decision-making/
[5]: https://github.com/joelparkerhenderson/architecture-decision-record
