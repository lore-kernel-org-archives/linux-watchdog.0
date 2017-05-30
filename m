Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([85.17.2.162]:36457 "EHLO spo001.leaseweb.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751024AbdE3LUG (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 30 May 2017 07:20:06 -0400
Date: Tue, 30 May 2017 13:20:00 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] watchdog updates for v4.12
Message-ID: <20170530112000.GA32657@spo001.leaseweb.nl>
References: <1494734105-15506-1-git-send-email-linux@roeck-us.net> <CAMuHMdV+6PWBj1W1Rt=mxg3BZSAWWarU1Gf_mYyX9TZCJam-QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdV+6PWBj1W1Rt=mxg3BZSAWWarU1Gf_mYyX9TZCJam-QA@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Geert,

> Hi Günter, Linus, Wim,
> 
> On Sun, May 14, 2017 at 5:55 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> > As requested by Wim:
> >
> > Please pull watchdog updates for Linux v4.12 from signed tag:
> >
> >     git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-linus-v4.12
> >
> > Note: I had to drop one of the patches affecting drivers/watchdog/iTCO_wdt.c
> > because it and some other patches affecting the same file came in from
> > another tree, causing severe and unnecessary conflicts. Other than that,
> > the tree is about two weeks old, even though it looks like some of the
> > patches are brand new.
> 
> What happened to this pull request?
> 
> It seems to have been superseded by "[GIT PULL REQUEST] watchdog - v4.12-rc1
> Fixes", which did get pulled, but the latter included less commits.
> 
> E.g. the rza_wdt driver was not included.
> In addition, it has also disappeared from linux-next?

The pull request was to late to include it in the merge window.
So we have to wait for the next merge window.
So that's why we sent in the fixes in before rc2 came out.
The other patches will be in the linux-next tree again in a couple of days.

Kind regards,
wim.

