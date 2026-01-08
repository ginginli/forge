# Canonical URL Issue Fix

## 🚨 Problem Identified
- URL: `https://forge-calculator.com/codes` 
- Status: "Alternate page with proper canonical tag"
- Issue: Google sees both `/codes` and `/codes.html` as separate URLs

## 🔍 Root Cause
The canonical tag currently points to `codes.html`, but the server might be serving the same content on both:
- `https://forge-calculator.com/codes` (without .html)
- `https://forge-calculator.com/codes.html` (with .html)

## 🛠️ Solution Options

### Option 1: Redirect `/codes` to `/codes.html` (Recommended)
- Keep current canonical tag pointing to `codes.html`
- Add server-side 301 redirect from `/codes` to `/codes.html`
- This maintains consistency with existing internal links

### Option 2: Change canonical to `/codes` (Alternative)
- Update canonical tag to point to `/codes` (without .html)
- Ensure all internal links point to `/codes`
- More modern URL structure

## 📋 Implementation Plan

### Immediate Fix (Option 1):
1. Keep canonical tag as `codes.html`
2. Add 301 redirect rule in server config
3. Update sitemap to use `codes.html`
4. Monitor Google Search Console

### Server Configuration Needed:
```apache
# Apache .htaccess
RewriteEngine On
RewriteRule ^codes$ /codes.html [R=301,L]
```

```nginx
# Nginx config
location = /codes {
    return 301 /codes.html;
}
```

## 🎯 Expected Result
- Google will recognize `codes.html` as the canonical URL
- `/codes` will redirect to `/codes.html`
- Eliminates duplicate content issues
- Improves SEO ranking potential