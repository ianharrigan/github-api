package github.api3;

@:enum
abstract Scope(String) from String to String {
    var REPO = "repo";
    var REPO_STATUS = "repo:status";
    var REPO_DEPLOYMENT = "repo_deployment";
    var PUBLIC_REPO = "public_repo";
    var REPO_INVITE = "repo:invite";
    var ADMIN_REPO_HOOK = "admin:repo_hook";
    var WRITE_REPO_HOOK = "write:repo_hook";
    var READ_REPO_HOOK = "read:repo_hook";
    var ADMIN_ORG = "admin:org";
    var WRITE_ORG = "write:org";
    var READ_ORG = "read:org";
    var ADMIN_PUBLIC_KEY = "admin:public_key";
    var WRITE_PUBLIC_KEY = "write:public_key";
    var READ_PUBLIC_KEY = "read:public_key";
    var ADMIN_ORG_HOOK = "admin:org_hook";
    var GIST = "gist";
    var NOTIFICATIONS = "notifications";
    var USER = "user";
    var READ_USER = "read:user";
    var USER_EMAIL = "user:email";
    var USER_FOLLOW = "user:follow";
    var DELTE_REPO = "delete_repo";
    var WRITE_DISCUSSION = "write:discussion";
    var READ_DISCUSSION = "read:discussion";
    var WRITE_PACKAGES = "write:packages";
    var READ_PACKAGES = "read:packages";
    var ADMIN_GPG_KEY = "admin:gpg_key";
    var WRITE_GPG_KEY = "write:gpg_key";
    var READ_GPG_KEY = "read:gpg_key";
    var WORKFLOW = "workflow";
}