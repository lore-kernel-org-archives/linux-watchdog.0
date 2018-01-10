Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46186 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753742AbeAJAaL (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 9 Jan 2018 19:30:11 -0500
Received: by mail-qt0-f195.google.com with SMTP id r39so20081722qtr.13
        for <linux-watchdog@vger.kernel.org>; Tue, 09 Jan 2018 16:30:10 -0800 (PST)
Message-ID: <1515544209.3456.2.camel@redhat.com>
Subject: Re: [11/12] watchdog: sp5100-tco: Abort if watchdog is disabled by
 hardware
From: Lyude Paul <lyude@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?ISO-8859-1?Q?Zolt=E1n_B=F6sz=F6rm=E9nyi?= <zboszor@pr.hu>
Date: Tue, 09 Jan 2018 19:30:09 -0500
In-Reply-To: <20180110001125.GB6500@roeck-us.net>
References: <1514149457-20273-12-git-send-email-linux@roeck-us.net>
         <1515538687.4373.18.camel@redhat.com> <20180109233703.GD26819@roeck-us.net>
         <1515542665.3456.0.camel@redhat.com> <20180110001125.GB6500@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Oh fantastic! this works awesome, thank you ♥

On Tue, 2018-01-09 at 16:11 -0800, Guenter Roeck wrote:
> On Tue, Jan 09, 2018 at 07:04:25PM -0500, Lyude Paul wrote:
> > How exactly did you go about enabling the Super-IO watchdog on your MSI
> > board?
> >  This is an MSI A320M that I'm trying to make work here
> > 
> 
> MSI boards use NCT679x Super-IO chips. The watchdog on those chips is
> supported
> by the w83627hf_wdt driver (since v4.13). If you have an older kernel, the
> relevant commit is 3a9aedb282a ("watchdog: w83627hf: Add support for
> NCT6793D
> and NCT6795D").
> 
> Guenter
> 
> > On Tue, 2018-01-09 at 15:37 -0800, Guenter Roeck wrote:
> > > Hi,
> > > 
> > > On Tue, Jan 09, 2018 at 05:58:07PM -0500, Lyude Paul wrote:
> > > > Hi! I'm the one from the Fedora bugzilla who said they'd help review
> > > > these
> > > > patches. I might end up responding to this with a real review comment
> > > > after
> > > > this message, but first:
> > > > 
> > > > mind cc'ing me future versions of this patchset and also, is there any
> > > > way
> > > > you
> > > 
> > > Sure.
> > > 
> > > > know of that one could figure out whether or not the sp5100_tco wdt is
> > > > actually disabled by the OEM on a board? I tried testing these patches
> > > > with my
> > > 
> > > That is what the code is trying to do today.
> > > 
> > > > system and it appears to be convinced that it's disabled on my system,
> > > > but
> > > > I'm
> > > > hoping something in this patch is just broken…
> > > > 
> > > 
> > > I tested the driver on three different boards. MSI B350M MORTAR,
> > > MSI B350 TOMAHAWK, and Gigabyte AB350M-Gaming 3. CPU is Ryzen 1700X
> > > on all boards.
> > > 
> > > On the MSI boards, the watchdog is reported as disabled. Enabling it
> > > and letting it expire does not have an effect. I am using the Super-IO
> > > watchdog instead on those boards (and it works).
> > > 
> > > On the Gigabyte board, the watchdog is reported as enabled, and it works
> > > (and the watchdog on the Super-IO chips does not work).
> > > 
> > > Feel free to play with the driver. Maybe there is a means to enable the
> > > watchdog if it is disabled. Unfortunately, I was unable to figure out
> > > how
> > > to do it, so I thought it is better to report the fact and not
> > > instantiate
> > > the watchdog if it doesn't work.
> > > 
> > > Hope this helps,
> > > Guenter
> > 
> > -- 
> > Cheers,
> > 	Lyude Paul
-- 
Cheers,
	Lyude Paul
