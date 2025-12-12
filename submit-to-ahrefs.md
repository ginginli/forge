# Submit URLs to Ahrefs

## Method 1: Manual Submission via Ahrefs Dashboard
1. Go to Ahrefs Webmaster Tools
2. Navigate to Site Audit or Site Explorer
3. Use the "Submit URL" feature
4. Paste URLs from `ahrefs-urls.txt`

## Method 2: Using curl (Single URL)
```bash
curl -X POST "https://api.ahrefs.com/v3/site-explorer/url-rating?url=https://forge-calculator.com/&key_location=https://forge-calculator.com/599a0d628c834338ac489c0192d9915e.txt"
```

## Method 3: Bulk Submission Script
Run the provided script:
```bash
./submit_to_ahrefs.sh
```

## All URLs to Submit:
- https://forge-calculator.com/
- https://forge-calculator.com/wiki/
- https://forge-calculator.com/codes.html
- https://forge-calculator.com/recipes/
- https://forge-calculator.com/ore/
- https://forge-calculator.com/weapons.html
- https://forge-calculator.com/races.html
- https://forge-calculator.com/enemies.html
- https://forge-calculator.com/npcs.html
- https://forge-calculator.com/feedback.html
- https://forge-calculator.com/blog/
- https://forge-calculator.com/blog-mastering-the-forge.html
- https://forge-calculator.com/blog-introducing-calculator.html
- https://forge-calculator.com/privacy-policy.html
- https://forge-calculator.com/terms-of-service.html
- https://forge-calculator.com/sitemap.xml

## Key Location
Your verification key is hosted at:
https://forge-calculator.com/599a0d628c834338ac489c0192d9915e.txt
