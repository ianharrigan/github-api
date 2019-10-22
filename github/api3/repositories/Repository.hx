package github.api3.repositories;

import github.api3.users.User;

class Repository {
                                        public var id:Int;
    @:alias("node_id")                  public var nodeId:String;
                                        public var name:String;
    @:alias("full_name")                public var fullName:String;
    @:alias("private")                  public var isPrivate:Bool;
                                        public var owner:User;
    @:alias("html_url")                 public var htmlUrl:String;
                                        public var description:String;
                                        public var fork:Bool;
                                        public var url:String;
    @:alias("forks_url")                public var forksUrl:String;
    @:alias("collaborators_url")        public var collaboratorsUrl:String;
    @:alias("teams_url")                public var teamsUrl:String;
    @:alias("hooks_url")                public var hooksUrl:String;
    @:alias("issue_events_url")         public var issueEventsUrl:String;
    @:alias("events_url")               public var eventsUrl:String;
    @:alias("assignees_url")            public var assigneesUrl:String;
    @:alias("branches_url")             public var branchesUrl:String;
    @:alias("tags_url")                 public var tagsUrl:String;
    @:alias("blobs_url")                public var blobsUrl:String;
    @:alias("git_tags_url")             public var git_tagsUrl:String;
    @:alias("git_refs_url")             public var gitRefsUrl:String;
    @:alias("trees_url")                public var treesUrl:String;
    @:alias("statuses_url")             public var statusesUrl:String;
    @:alias("languages_url")            public var languagesUrl:String;
    @:alias("stargazers_url")           public var stargazersUrl:String;
    @:alias("contributors_url")         public var contributorsUrl:String;
    @:alias("subscribers_url")          public var subscribersUrl:String;
    @:alias("subscription_url")         public var subscriptionUrl:String;
    @:alias("commits_url")              public var commitsUrl:String;
    @:alias("git_commits_url")          public var gitCommitsUrl:String;
    @:alias("comments_url")             public var commentsUrl:String;
    @:alias("issue_comment_url")        public var issueCommentUrl:String;
    @:alias("contents_url")             public var contentsUrl:String;
    @:alias("compare_url")              public var compareUrl:String;
    @:alias("merges_url")               public var mergesUrl:String;
    @:alias("archive_url")              public var archiveUrl:String;
    @:alias("downloads_url")            public var downloadsUrl:String;
    @:alias("issues_url")               public var issuesUrl:String;
    @:alias("pulls_url")                public var pullsUrl:String;
    @:alias("milestones_url")           public var milestonesUrl:String;
    @:alias("notifications_url")        public var notificationsUrl:String;
    @:alias("labels_url")               public var labelsUrl:String;
    @:alias("releases_url")             public var releasesUrl:String;
    @:alias("deployments_url")          public var deploymentsUrl:String;
    
    
    public function new() {
    }
}