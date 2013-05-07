Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:55504 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755820Ab3EGVRY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 May 2013 17:17:24 -0400
Date: Tue, 7 May 2013 22:17:22 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Subject: Re: [RFC] watchdog ->release() races
Message-ID: <20130507211722.GS25399@ZenIV.linux.org.uk>
References: <20130507201001.GR25399@ZenIV.linux.org.uk>
 <CA+55aFwxBj-+r3z_1JgAG4Tv5p3NF-WTaYedYNGq9jDq+riOaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwxBj-+r3z_1JgAG4Tv5p3NF-WTaYedYNGq9jDq+riOaw@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, May 07, 2013 at 02:00:02PM -0700, Linus Torvalds wrote:
> On Tue, May 7, 2013 at 1:10 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > It's obviously racy; I'm not sure if we care about that race, but if we
> > do, there's about 80 drivers that need to be fixed...
> 
> I suspect the "we don't really care" is the correct answer here. It's
> not like you can really screw things up by mistake, and if you try to
> screw this up on purpose, you need to be root anyway to open
> /dev/watchdog etc.

I'm not sure...  It's obviously not a "the sky is falling" kind of thing,
but in a situation when task B kills task A, then spins trying to open
until open() succeeds...  Hell knows; it might be triggerable by somebody
not trying to trigger the race on purpose.  I really don't know what does
the userland side of that thing look like, thus the Cc to linux-wtchdog...
