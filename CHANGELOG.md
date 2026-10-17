# Changelog

All notable changes to Puddlewick Isle. New releases are added at the top.

## v1.2.0 (2026-10-17 13:36)
**New features**
- **Saturday Derby**: every Saturday from 9 AM to 6 PM, Marlowe the otter runs a 3-minute Fishing Derby or Bug-Off in the plaza. The two alternate weekly. Points pay Tide Points and win bronze, silver and gold trophies.
- **Isle Bloom Rating**: Hazel rates your island from 0 to 5 stars on a new Town Hall tab, offers advice, and mails a one-time reward for each new star. The score counts flowers, trees, residents, furniture, museum donations and your home, and weeds and litter lower it.

**Improvements**
- Gift letters are no longer deleted when the mailbox overflows. The gift moves to storage or your pockets.
- When your pockets are full, items drop at your feet, go to storage or arrive as a Lost & Found letter.
- Hazards and timers freeze while menus or dialogs are open.
- The update loop allocates fewer arrays per frame, which keeps frame times smoother.
- Screen shake is now real, and a new Reduce motion setting (Auto, On or Off) follows the system preference.
- The layout works better on phones in landscape and on small screens, and screen readers still announce the tool name.
- Heart Day on February 14: friends mail Heart chocolates and best friends send furniture.
- The Critterpedia has Now, Leaving and Undonated filters, plus a reminder near month end when critters are about to leave.

## v1.1.0 (2026-10-17)
**PWA & deployment release**: installable progressive web app with offline support, full metadata for search and social sharing, and a headless-Chrome test suite.

- **Progressive Web App**: service worker (network-first caching), web manifest, and app icons so the game installs on phones and desktops and works offline.
- **SEO & social**: meta description, Open Graph and Twitter Card tags, canonical URL, robots index/follow, and a 1200×630 OG image.
- **Content-Security-Policy update**: added `img-src 'self'`, `manifest-src 'self'` and `worker-src 'self'` so PWA assets load under the strict CSP.
- **APP_VERSION constant**: exposed on `window.PW.APP_VERSION` for tests and upgrade automation.
- **Test suite**: three headless-Chrome harnesses (smoke, gameplay, features) with ~60 assertions and a `tests/run.sh` runner.
- **Fishing test fix**: corrected beach-spot facing direction so the rod-cast assertion passes reliably.
- **README**: features table, screenshot grid, controls, install-as-app instructions, and changelog link.
- **404 redirect**: GitHub Pages 404 page redirects to the game.

## v1.0.0 (2026-10-17)
**Initial release**: a single-file, Animal Crossing-inspired island life sim with original characters and art.
- **Real-time world**: real-time clock with a 5 AM day reset, Northern and Southern hemispheres, four seasons with matching visuals, weather seeded per day, and night lighting.
- **Procedural islands**: seeded generation with rivers, bridges, ponds, a plaza, paths and buildings (Town Hall, Bramble's store, museum, home, five house plots, dock).
- **Fishing**: 38 fish with shadow sizes, finned and narrow shadows, 1–4 nibbles then a bite window, bait from manila clams, and junk catches.
- **Bugs**: 34 bugs with spawn types (flying, flowers, trees, ground, rocks, beach, ponds, shaken from trees), fleeing behavior, tiptoeing, wasp stings, and chasing tarantulas and scorpions.
- **Museum and Critterpedia**: fossil assessment, donations, and exhibit halls for fish, bugs and fossils.
- **Trees, rocks and digging**: fruit, furniture, chime bags and wasp nests from shaking; wood from chopping; stone, clay, iron, gold and a daily money rock; fossil cracks, glowing spots and clam bubbles.
- **Gardening**: six flower species, growth stages, watering, and hybrid breeding; planting fruit trees, palms and saplings.
- **DIY crafting**: about 30 recipes, flimsy and sturdy tools, and recipe sources (bottles, balloons, neighbors, store, Tide Points).
- **Economy**: Bramble's store (daily stock, hot item, drop-off box), the sunroot stalk market (4 patterns plus the transition table), bank interest, and home loans (tent → cottage → house → big house → manor).
- **Neighbors**: 16 original villagers with 8 personalities and burbling typed speech, plus friendship, gifts, requests, birthdays, letters, Spooky Night candy, and mystery-island campers who can move in.
- **Home decorating**: furniture placement, fish tanks and bug cases, wallpaper and flooring, storage, a workbench, and a Happy Home score.
- **Tide Points**: 22 tiered achievements, 5 daily tasks, and redeemable upgrades (pockets, tools, tickets).
- **ShellPhone**: Tide Points, Critterpedia, DIY, Map, Sunroots, Neighbors, Calendar, Camera, Settings (volume, hemisphere, time travel, export/import) and Guide.
- **Extras**: balloon presents and the slingshot, meteor showers and wishes, August Sunday fireworks, New Year and festive events, and generative hourly music.
- **Platform**: keyboard and touch controls, autosave, and a headless-Chrome test suite.
