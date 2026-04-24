# Apps Script source (mirrored)

The file `Code.gs` next to this README is based on the upstream script you deploy in your own Google Apps Script project:

- Upstream: <https://github.com/masterking32/MasterHttpRelayVPN/blob/python_testing/apps_script/Code.gs>
- Raw link: <https://raw.githubusercontent.com/masterking32/MasterHttpRelayVPN/refs/heads/python_testing/apps_script/Code.gs>

This copy lives in our repo for three reasons:

1. **Survives upstream outages**: if the user is on a network where raw.githubusercontent.com is temporarily unreachable but they can clone or ZIP this repo, they still have the deploy-ready file.
2. **Pins what we tested against**: the relay protocol between `mhrv-rs` and the script is informal; upstream changes can silently break us. Keeping a snapshot here lets us diff and see if a spec drift is responsible for any reported breakage.
3. **Allows small compatibility patches**: we may apply minimal, documented changes needed by this Rust client while keeping protocol compatibility.

All credit for the original `Code.gs` goes to [@masterking32](https://github.com/masterking32). If you're using mhrv-rs, follow the deploy instructions in the script's header comment. The only edit **you** must make is the `AUTH_KEY` constant — set it to a strong secret and reuse that exact string in your `mhrv-rs` config.

## Known limitation: Cloudflare Turnstile loops

On many Cloudflare-protected sites, the "Verify you are human" challenge can
loop endlessly when traffic goes through Apps Script.

Why this happens:

- Apps Script requests can egress from different Google datacenter IPs across
  successive requests.
- `User-Agent` (`Google-Apps-Script`) and TLS fingerprint are controlled by
  Google, not by this client.
- Cloudflare commonly binds `cf_clearance` to `(IP, UA, JA3)` from the solved
  challenge.

So if IP changes between requests, Cloudflare re-challenges.

There is no app-side fix for this within the Apps Script relay architecture.
Sites that only challenge the first page load (and not every request) may still
work after one successful verification.
