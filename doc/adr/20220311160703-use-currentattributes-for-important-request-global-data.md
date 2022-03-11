# 20220311160703. Use CurrentAttributes for important request global data

Date: 2022-03-11


## Status

Status: Accepted


## References

- [`ActiveSupport::CurrentAttributes`](https://api.rubyonrails.org/v7.0.2.3/classes/ActiveSupport/CurrentAttributes.html)


## Problem Statement and Context

There are certain key resources that get loaded on a large majority of requests. These resources
need a defined strategy to make working with them, within a request cycle, consistent.


### Decision Drivers

In addition to codifying a consistent method for handling key resources, we need to think about how
we can also expose this information to bug reports (e.g. Bugsnag) and various telemetry recorders
(Honeycomb, New Relic, Datadog, etc.).


## Alternatives and Options Explored

Due to time constraints not may alternatives were explored.

One strategy employed in some code bases is to define accessors in a controller and also define them
as helper methods:

```ruby
class WidgetsController < ApplicationController
  attr_accessor :current_user
  helper_method :current_user
end
```

This generally works for reference in controllers and views, but it doesn't make it easy to
reference this information outside of those contexts (e.g. bug reports or telemetry).


## Decision

**Use `ActiveSupport::CurrentAttributes` for these key resources.**

This tool is built into Rails. Rails knows how to ensure it is properly cleaned up after the request
cycle. It also provides a seam for other future tools (e.g. bug reports or telemetry) to hook into
or access in configuration hooks.

The Rails docs give an example using the name `Current`. We didn't find that name very descriptive.
We're going to use an similarly terse name, but one we find slightly more descriptive: `AppContext`.


## Consequences

Any resources defined in `AppContext` should be referenced through it for consistency. This means
utilizing it in both controllers and views instead of instance variables.

This context is intended to store key resources. Not every resource endpoint will fit that
definition. A good example of what you may want to include is if that information would be a good
segmentation parameter for telemetry queries.

When in doubt ask the team for feedback on if a resource should be included.
