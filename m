Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:53684 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823Ab3EGVAD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 May 2013 17:00:03 -0400
Received: by mail-vc0-f178.google.com with SMTP id kw10so1006114vcb.37
        for <linux-watchdog@vger.kernel.org>; Tue, 07 May 2013 14:00:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130507201001.GR25399@ZenIV.linux.org.uk>
References: <20130507201001.GR25399@ZenIV.linux.org.uk>
Date: Tue, 7 May 2013 14:00:02 -0700
Message-ID: <CA+55aFwxBj-+r3z_1JgAG4Tv5p3NF-WTaYedYNGq9jDq+riOaw@mail.gmail.com>
Subject: Re: [RFC] watchdog ->release() races
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, May 7, 2013 at 1:10 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> It's obviously racy; I'm not sure if we care about that race, but if we
> do, there's about 80 drivers that need to be fixed...

I suspect the "we don't really care" is the correct answer here. It's
not like you can really screw things up by mistake, and if you try to
screw this up on purpose, you need to be root anyway to open
/dev/watchdog etc.

               Linus
