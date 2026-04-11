---
name: update-marketing
description: Record marketing data snapshots (Steam wishlists, Reddit ads) to the persistent wishlists.json memory file. Use when the user shares new screenshots or stats from Steam Steamworks or Reddit Ads dashboards.
---

# Update Marketing Data

Append a new date-stamped snapshot to `C:\Users\blake\.claude\projects\c--Projects-PartingShadows\memory\wishlists.json`.

## When to Run

- When the user shares Steam Steamworks dashboard screenshots or stats
- When the user shares Reddit Ads dashboard screenshots or stats
- When the user provides updated wishlist counts, ad performance, or geo data
- Periodically when asked to log current marketing state

## Data File

`C:\Users\blake\.claude\projects\c--Projects-PartingShadows\memory\wishlists.json`

The file is a JSON object with a single `snapshots` array. Each entry is a daily snapshot.

## Procedure

### Step 1: Read current data

Read `wishlists.json` and find the latest snapshot date to avoid duplicates.

### Step 2: Collect data from user

Extract whatever the user has provided. Not all fields are required every snapshot -- only include what's available. Common sources:

**From Steam Steamworks:**
- `outstanding_wishlists` -- current wishlist balance
- `period_adds` / `period_deletes` / `period_balance` -- daily or period changes
- `lifetime_unique_users`, `daily_active_users`, `median_time_played`
- Geo breakdowns by region and country (if provided)

**From Reddit Ads:**
- `campaign_budget_daily` -- current daily budget
- `totals` -- aggregate impressions, clicks, CTR, CPC, eCPM
- `by_ad` -- per-ad breakdown (name, status, impressions, clicks, ecpm, cpc, ctr_pct)
- Any campaign changes (new creatives, disabled ads, targeting changes)

### Step 3: Build snapshot entry

```json
{
  "date": "YYYY-MM-DD",
  "note": "Brief note on what changed (optional)",
  "steam": {
    "outstanding_wishlists": 199,
    "period_adds": 78,
    "period_deletes": 4,
    "period_balance": 74,
    "lifetime_unique_users": 11,
    "daily_active_users": 2,
    "median_time_played": "6 minutes",
    "geo": {
      "by_region": { ... },
      "by_country": { ... }
    }
  },
  "reddit_ads": {
    "campaign_budget_daily": 40.00,
    "bid_strategy": "lowest_cost",
    "totals": {
      "impressions": 134859,
      "clicks": 1067,
      "ctr_pct": 0.791,
      "cpc": 0.07,
      "ecpm": 0.55
    },
    "by_ad": [
      { "name": "Audience - Creative", "status": "active", "impressions": 0, "clicks": 0, "ecpm": 0.00, "cpc": 0.00, "ctr_pct": 0.000 }
    ],
    "insights": {
      "best_creative": "...",
      "best_audience": "...",
      "click_to_wishlist_rate_pct": 0.0
    }
  }
}
```

### Step 4: Update or append

- If a snapshot for today's date already exists, **update it** with new data (merge, don't overwrite fields that aren't being updated).
- If no snapshot exists for today, **append** a new entry to the `snapshots` array.

### Step 5: Calculate insights

When both Steam and Reddit data are available for the same period:
- `click_to_wishlist_rate_pct` = new wishlists / new clicks * 100
- Note any significant changes from the previous snapshot (CTR shifts, CPC changes, budget changes, new creatives)

### Step 6: Report

```
MARKETING DATA UPDATED (YYYY-MM-DD)

Steam:
  Outstanding wishlists: N (+N today)

Reddit Ads:
  Impressions: N | Clicks: N | CTR: N% | CPC: $N
  Budget: $N/day
  Top performer: [ad name] (N% CTR)

Estimated click-to-wishlist: N%

RESULT: SNAPSHOT SAVED / SNAPSHOT UPDATED
```

## Field Reference

### Steam fields
| Field | Type | Description |
|-------|------|-------------|
| outstanding_wishlists | int | Current total wishlist balance |
| period_adds | int | Wishlists added in period |
| period_deletes | int | Wishlists removed in period |
| period_balance | int | Net change (adds - deletes) |
| lifetime_unique_users | int | Total unique players |
| daily_active_users | int | 7-day average DAU |
| median_time_played | string | Median play session length |
| geo | object | Geographic breakdown |

### Reddit Ads fields
| Field | Type | Description |
|-------|------|-------------|
| campaign_budget_daily | float | Daily budget in USD |
| bid_strategy | string | "lowest_cost" or "cost_cap" |
| impressions | int | Total ad impressions |
| clicks | int | Total ad clicks |
| ctr_pct | float | Click-through rate as percentage |
| cpc | float | Cost per click in USD |
| ecpm | float | Effective cost per 1000 impressions |

### Ad naming convention
Ads follow the pattern: `{Audience} - {Creative}`
- Audiences: Indie Gaming, Broad Gaming, Core RPG
- Creatives: Battle Scene, Main Trailer, Short Trailer, Cult Ritual Battle, Dream Nexus Battle, Title Screen
