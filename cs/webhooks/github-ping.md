# github repo webhook setup webhook

## POST request

## header

host
eni32m1ikkyu.x.pipedream.net

x-amzn-trace-id
Root=1-66509e3d-20d5be1c6d9533cf59c3e3e3

content-length
9075

user-agent
GitHub-Hookshot/fa53f14

accept
*/*

content-type
application/x-www-form-urlencoded

x-github-delivery
6cbe20b0-19d6-11ef-8f59-32629cd4200a

x-github-event
ping

x-github-hook-id
480171412

x-github-hook-installation-target-id
765383690

x-github-hook-installation-target-type
repository


## body

```json
{
  "root": {
    "payload": {
      "zen": "Speak like a human.",
      "hook_id": 480171412,
      "hook": {
        "type": "Repository",
        "id": 480171412,
        "name": "web",
        "active": true,
        "events": ["push"],
        "config": {
          "content_type": "form",
          "insecure_ssl": "0",
          "url": "https://eni32m1ikkyu.x.pipedream.net/"
        },
        "updated_at": "2024-05-24T14:03:40Z",
        "created_at": "2024-05-24T14:03:40Z",
        "url": "https://api.github.com/repos/jjmchew/capstone/hooks/480171412",
        "test_url": "https://api.github.com/repos/jjmchew/capstone/hooks/480171412/test",
        "ping_url": "https://api.github.com/repos/jjmchew/capstone/hooks/480171412/pings",
        "deliveries_url": "https://api.github.com/repos/jjmchew/capstone/hooks/480171412/deliveries",
        "last_response": {
          "code": null,
          "status": "unused",
          "message": null
        }
      },
      "repository": {
        "id": 765383690,
        "node_id": "R_kgDOLZ7UCg",
        "name": "capstone",
        "full_name": "jjmchew/capstone",
        "private": true,
        "owner": {
          "login": "jjmchew",
          "id": 49774645,
          "node_id": "MDQ6VXNlcjQ5Nzc0NjQ1",
          "avatar_url": "https://avatars.githubusercontent.com/u/49774645?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/jjmchew",
          "html_url": "https://github.com/jjmchew",
          "followers_url": "https://api.github.com/users/jjmchew/followers",
          "following_url": "https://api.github.com/users/jjmchew/following{/other_user}",
          "gists_url": "https://api.github.com/users/jjmchew/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/jjmchew/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/jjmchew/subscriptions",
          "organizations_url": "https://api.github.com/users/jjmchew/orgs",
          "repos_url": "https://api.github.com/users/jjmchew/repos",
          "events_url": "https://api.github.com/users/jjmchew/events{/privacy}",
          "received_events_url": "https://api.github.com/users/jjmchew/received_events",
          "type": "User",
          "site_admin": false
        },
        "html_url": "https://github.com/jjmchew/capstone",
        "description": null,
        "fork": false,
        "url": "https://api.github.com/repos/jjmchew/capstone",
        "forks_url": "https://api.github.com/repos/jjmchew/capstone/forks",
        "keys_url": "https://api.github.com/repos/jjmchew/capstone/keys{/key_id}",
        "collaborators_url": "https://api.github.com/repos/jjmchew/capstone/collaborators{/collaborator}",
        "teams_url": "https://api.github.com/repos/jjmchew/capstone/teams",
        "hooks_url": "https://api.github.com/repos/jjmchew/capstone/hooks",
        "issue_events_url": "https://api.github.com/repos/jjmchew/capstone/issues/events{/number}",
        "events_url": "https://api.github.com/repos/jjmchew/capstone/events",
        "assignees_url": "https://api.github.com/repos/jjmchew/capstone/assignees{/user}",
        "branches_url": "https://api.github.com/repos/jjmchew/capstone/branches{/branch}",
        "tags_url": "https://api.github.com/repos/jjmchew/capstone/tags",
        "blobs_url": "https://api.github.com/repos/jjmchew/capstone/git/blobs{/sha}",
        "git_tags_url": "https://api.github.com/repos/jjmchew/capstone/git/tags{/sha}",
        "git_refs_url": "https://api.github.com/repos/jjmchew/capstone/git/refs{/sha}",
        "trees_url": "https://api.github.com/repos/jjmchew/capstone/git/trees{/sha}",
        "statuses_url": "https://api.github.com/repos/jjmchew/capstone/statuses/{sha}",
        "languages_url": "https://api.github.com/repos/jjmchew/capstone/languages",
        "stargazers_url": "https://api.github.com/repos/jjmchew/capstone/stargazers",
        "contributors_url": "https://api.github.com/repos/jjmchew/capstone/contributors",
        "subscribers_url": "https://api.github.com/repos/jjmchew/capstone/subscribers",
        "subscription_url": "https://api.github.com/repos/jjmchew/capstone/subscription",
        "commits_url": "https://api.github.com/repos/jjmchew/capstone/commits{/sha}",
        "git_commits_url": "https://api.github.com/repos/jjmchew/capstone/git/commits{/sha}",
        "comments_url": "https://api.github.com/repos/jjmchew/capstone/comments{/number}",
        "issue_comment_url": "https://api.github.com/repos/jjmchew/capstone/issues/comments{/number}",
        "contents_url": "https://api.github.com/repos/jjmchew/capstone/contents/{+path}",
        "compare_url": "https://api.github.com/repos/jjmchew/capstone/compare/{base}...{head}",
        "merges_url": "https://api.github.com/repos/jjmchew/capstone/merges",
        "archive_url": "https://api.github.com/repos/jjmchew/capstone/{archive_format}{/ref}",
        "downloads_url": "https://api.github.com/repos/jjmchew/capstone/downloads",
        "issues_url": "https://api.github.com/repos/jjmchew/capstone/issues{/number}",
        "pulls_url": "https://api.github.com/repos/jjmchew/capstone/pulls{/number}",
        "milestones_url": "https://api.github.com/repos/jjmchew/capstone/milestones{/number}",
        "notifications_url": "https://api.github.com/repos/jjmchew/capstone/notifications{?since,all,participating}",
        "labels_url": "https://api.github.com/repos/jjmchew/capstone/labels{/name}",
        "releases_url": "https://api.github.com/repos/jjmchew/capstone/releases{/id}",
        "deployments_url": "https://api.github.com/repos/jjmchew/capstone/deployments",
        "created_at": "2024-02-29T20:15:09Z",
        "updated_at": "2024-05-24T03:14:32Z",
        "pushed_at": "2024-05-24T03:14:29Z",
        "git_url": "git://github.com/jjmchew/capstone.git",
        "ssh_url": "git@github.com:jjmchew/capstone.git",
        "clone_url": "https://github.com/jjmchew/capstone.git",
        "svn_url": "https://github.com/jjmchew/capstone",
        "homepage": null,
        "size": 745,
        "stargazers_count": 0,
        "watchers_count": 0,
        "language": "Python",
        "has_issues": true,
        "has_projects": true,
        "has_downloads": true,
        "has_wiki": false,
        "has_pages": false,
        "has_discussions": false,
        "forks_count": 0,
        "mirror_url": null,
        "archived": false,
        "disabled": false,
        "open_issues_count": 0,
        "license": null,
        "allow_forking": true,
        "is_template": false,
        "web_commit_signoff_required": false,
        "topics": [],
        "visibility": "private",
        "forks": 0,
        "open_issues": 0,
        "watchers": 0,
        "default_branch": "main"
      },
      "sender": {
        "login": "jjmchew",
        "id": 49774645,
        "node_id": "MDQ6VXNlcjQ5Nzc0NjQ1",
        "avatar_url": "https://avatars.githubusercontent.com/u/49774645?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/jjmchew",
        "html_url": "https://github.com/jjmchew",
        "followers_url": "https://api.github.com/users/jjmchew/followers",
        "following_url": "https://api.github.com/users/jjmchew/following{/other_user}",
        "gists_url": "https://api.github.com/users/jjmchew/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/jjmchew/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/jjmchew/subscriptions",
        "organizations_url": "https://api.github.com/users/jjmchew/orgs",
        "repos_url": "https://api.github.com/users/jjmchew/repos",
        "events_url": "https://api.github.com/users/jjmchew/events{/privacy}",
        "received_events_url": "https://api.github.com/users/jjmchew/received_events",
        "type": "User",
        "site_admin": false
      }
    }
  }
}
```
