Return-Path: <linus971@gmail.com>
Return-path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAADWXX-_k5z=08P6sW_6xip+9SEyv+FmfCFFB2P+ux0=FDBeDw@mail.gmail.com>
References: <20171217105558.GA6260@infomag.iguana.be> <CAADWXX-_k5z=08P6sW_6xip+9SEyv+FmfCFFB2P+ux0=FDBeDw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 17 Dec 2017 13:20:17 -0800
Message-ID: <CA+55aFxdJf6uA-m8z0=eZb0dmObE2gEvcTwzcPGzY6KgfUHirw@mail.gmail.com>
Subject: Re: [GIT PULL REQUEST] watchdog - v4.15 Fixes
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, Dec 17, 2017 at 12:12 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Also, all of these commits were committed less than an hour before
> sending me the pull request, so I question the kind of testing they
> got..

Oh, and equally importantly, it's an unsigned pull request from a
non-secured site, so I think I'll skip this.

Yes, yes, I've allowed these guys, and haven't really enforced it, but
the rule for the last year or so has been that if it's not something
where I have good reason to trust the repository integrity (ie
kernel.org), I require signed tags for pull requests.

I note that the watchdog pulls I have from Guenter _are_ signed (and
also from kernel.org). And I don't have Wim's key in my keyring at
all, so presumably they've never been signed, but can we please start
doing that? Git signed tags are pretty darn simple to use.

                Linus
