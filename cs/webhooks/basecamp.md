# basecamp webhook sample

## headers

host
eni32m1ikkyu.x.pipedream.net

x-amzn-trace-id
Root=1-66509d4a-594869e0677ede9d50936147

content-length
6612

accept
*/*

accept-encoding
gzip, deflate

user-agent
Basecamp3 Webhook

content-type
application/json

x-request-id
1fb4d59a-9fd1-4490-ab2c-3b151345cc30

sentry-trace
997ac30b50d44ce99a207c2e97e6dcbc-b1a5a64eae7d42f3-0

baggage
sentry-trace_id=997ac30b50d44ce99a207c2e97e6dcbc,sentry-sample_rate=0.0001,sentry-sampled=false,sentry-environment=production,sentry-release=2b25af32b1e78f9248dafafeb3dd195be19ac9cb,sentry-public_key=ecd2cbf917454e9daa40541c86d0cabf,sentry-transaction=Webhook%3A%3ADeliveryJob



## body
```json
{
    "id": 11982566462,
    "kind": "document_content_changed",
    "details": {},
    "created_at": "2024-05-24T07:59:37.818-06:00",
    "recording": {
        "id": 7433101146,
        "status": "active",
        "visible_to_clients": false,
        "created_at": "2024-05-23T13:13:47.885-06:00",
        "updated_at": "2024-05-24T07:59:37.787-06:00",
        "title": "CDNs",
        "inherits_status": true,
        "type": "Document",
        "url": "https://3.basecampapi.com/3695031/buckets/36641615/documents/7433101146.json",
        "app_url": "https://3.basecamp.com/3695031/buckets/36641615/documents/7433101146",
        "bookmark_url": "https://3.basecampapi.com/3695031/my/bookmarks/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaEpJaTVuYVdRNkx5OWlZek12VW1WamIzSmthVzVuTHpjME16TXhNREV4TkRZX1pYaHdhWEpsYzE5cGJnWTZCa1ZVIiwiZXhwIjpudWxsLCJwdXIiOiJyZWFkYWJsZSJ9fQ==--51e71645f80d189d2b7d16864093d16cd6cd7fd1.json",
        "subscription_url": "https://3.basecampapi.com/3695031/buckets/36641615/recordings/7433101146/subscription.json",
        "position": 2,
        "parent": {
            "id": 7422457841,
            "title": "Cheatsheets",
            "type": "Vault",
            "url": "https://3.basecampapi.com/3695031/buckets/36641615/vaults/7422457841.json",
            "app_url": "https://3.basecamp.com/3695031/buckets/36641615/vaults/7422457841"
        },
        "bucket": {
            "id": 36641615,
            "name": "ð¥ 2405 Capstone Cohort",
            "type": "Project"
        },
        "creator": {
            "id": 45559657,
            "attachable_sgid": "eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaEpJaWxuYVdRNkx5OWlZek12VUdWeWMyOXVMelExTlRVNU5qVTNQMlY0Y0dseVpYTmZhVzRHT2daRlZBPT0iLCJleHAiOm51bGwsInB1ciI6ImF0dGFjaGFibGUifX0=--fbb51fd3cdbb68aab50c148c10db3ba2e6a43f1c",
            "name": "James Chew",
            "email_address": "jjmchew@gmail.com",
            "personable_type": "User",
            "title": "",
            "bio": null,
            "location": null,
            "created_at": "2024-02-26T14:16:20.066-07:00",
            "updated_at": "2024-02-26T22:14:14.033-07:00",
            "admin": false,
            "owner": false,
            "client": false,
            "employee": false,
            "time_zone": "America/Denver",
            "avatar_url": "https://bc3-production-assets-cdn.basecamp-static.com/3695031/people/BAhpBGkvtwI=--e2310465a142cefa7f489575a00ffd550c3bbbbd/avatar?v=1",
            "company": {
                "id": 3192864,
                "name": "Capstone"
            },
            "can_ping": true,
            "can_manage_projects": true,
            "can_manage_people": true
        },
        "content": "<div><strong><br>What is a CDN? </strong></div><ul><li>Content Distribution/Delivery Network</li><li>A group of servers spread out globally to minimize the request latency of fetching (cached) static assets from a server</li></ul><div><br><strong>Why do we want to use a CDN?</strong></div><ul><li>as geographic distance between a user and a responding server increases, the latency of a response from that server increases</li><li>creating a global network of servers ensures that any given user is geographically close to a server in the CDN, which can then serve static assets with reduced latency</li><li>these static assets are cached from the origin server</li></ul><div><br><strong>What are the pros and cons to adding a CDN to a system?</strong></div><div>Pros</div><ul><li>reduces latency / improves load times</li><li>reduces load on origin / application servers</li></ul><div><br>Cons</div><ul><li>increased complexity: managing CDN and data updates<ul><li>need to balance availability with consistency</li></ul></li><li>generally involves introducing a 3rd party</li><li>price for CDN services can be expensive (custom features like SSL certificates, custom domains, advanced analytics may be extra)</li><li>If you donât have the traffic to justify a CDN (the cache must constantly update info in a âpullâ setup), then you may actually make response times slower</li></ul><div><br></div><div><strong>What are the two main types of CDNs?</strong></div><div>Push CDN</div><ul><li>engineers have the responsibility to push new/updated files to the CDN<ul><li>requires more work from engineers</li></ul></li><li>the CDN never makes requests to the origin server<ul><li>(there may be no need to run an origin server)</li></ul></li></ul><div><br>Pull CDN</div><ul><li>the server cache is lazily updated: if a request asset is NOT on the CDN server, then that asset is fetched from the origin server, populating the cache</li><li>more popular than push:<ul><li>easier to maintain</li><li>timestamps can be attached to manage stale data</li><li>usually support Cache-Control response headers</li></ul></li></ul><div><br></div><h1>References</h1><ul><li><a href=\"https://www.tryexponent.com/blog/cdns-content-delivery-networks\">https://www.tryexponent.com/blog/cdns-content-delivery-networks</a></li><li><a href=\"https://www.linkedin.com/pulse/what-disadvantages-using-cdn-blazingcdn-c1xbf/\">https://www.linkedin.com/pulse/what-disadvantages-using-cdn-blazingcdn-c1xbf/</a></li><li><a href=\"https://www.maxlaumeister.com/articles/3-reasons-not-to-use-a-cdn/\">https://www.maxlaumeister.com/articles/3-reasons-not-to-use-a-cdn/</a></li></ul>"
    },
    "creator": {
        "id": 45559657,
        "attachable_sgid": "eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaEpJaWxuYVdRNkx5OWlZek12VUdWeWMyOXVMelExTlRVNU5qVTNQMlY0Y0dseVpYTmZhVzRHT2daRlZBPT0iLCJleHAiOm51bGwsInB1ciI6ImF0dGFjaGFibGUifX0=--fbb51fd3cdbb68aab50c148c10db3ba2e6a43f1c",
        "name": "James Chew",
        "email_address": "jjmchew@gmail.com",
        "personable_type": "User",
        "title": "",
        "bio": null,
        "location": null,
        "created_at": "2024-02-26T14:16:20.066-07:00",
        "updated_at": "2024-02-26T22:14:14.033-07:00",
        "admin": false,
        "owner": false,
        "client": false,
        "employee": false,
        "time_zone": "America/Denver",
        "avatar_url": "https://bc3-production-assets-cdn.basecamp-static.com/3695031/people/BAhpBGkvtwI=--e2310465a142cefa7f489575a00ffd550c3bbbbd/avatar?v=1",
        "company": {
            "id": 3192864,
            "name": "Capstone"
        },
        "can_ping": true,
        "can_manage_projects": true,
        "can_manage_people": true
    }
}

```