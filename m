Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45207 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752305AbeAJAFf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 9 Jan 2018 19:05:35 -0500
Date: Tue, 9 Jan 2018 16:05:32 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Gabriel C <nix.or.die@gmail.com>
Cc: Lyude Paul <lyude@redhat.com>, Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?iso-8859-1?B?Wm9sdOFuIEL2c3r2cm3pbnlp?= <zboszor@pr.hu>
Subject: Re: [11/12] watchdog: sp5100-tco: Abort if watchdog is disabled by
 hardware
Message-ID: <20180110000532.GA6500@roeck-us.net>
References: <1514149457-20273-12-git-send-email-linux@roeck-us.net>
 <1515538687.4373.18.camel@redhat.com>
 <20180109233703.GD26819@roeck-us.net>
 <4b56f6ba-bf76-a500-087a-49f34cd4b5d5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b56f6ba-bf76-a500-087a-49f34cd4b5d5@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On Wed, Jan 10, 2018 at 12:58:00AM +0100, Gabriel C wrote:
> On 10.01.2018 00:37, Guenter Roeck wrote:
> >Hi,
> >
> >On Tue, Jan 09, 2018 at 05:58:07PM -0500, Lyude Paul wrote:
> >>Hi! I'm the one from the Fedora bugzilla who said they'd help review these
> >>patches. I might end up responding to this with a real review comment after
> >>this message, but first:
> >>
> >>mind cc'ing me future versions of this patchset and also, is there any way you
> >
> >Sure.
> >
> >>know of that one could figure out whether or not the sp5100_tco wdt is
> >>actually disabled by the OEM on a board? I tried testing these patches with my
> >
> >That is what the code is trying to do today.
> >
> >>system and it appears to be convinced that it's disabled on my system, but I'm
> >>hoping something in this patch is just broken…
> >>
> >
> >I tested the driver on three different boards. MSI B350M MORTAR,
> >MSI B350 TOMAHAWK, and Gigabyte AB350M-Gaming 3. CPU is Ryzen 1700X
> >on all boards.
> >
> >On the MSI boards, the watchdog is reported as disabled. Enabling it
> >and letting it expire does not have an effect. I am using the Super-IO
> >watchdog instead on those boards (and it works).
> >
> >On the Gigabyte board, the watchdog is reported as enabled, and it works
> >(and the watchdog on the Super-IO chips does not work).
> >
> >Feel free to play with the driver. Maybe there is a means to enable the
> >watchdog if it is disabled. Unfortunately, I was unable to figure out how
> >to do it, so I thought it is better to report the fact and not instantiate
> >the watchdog if it doesn't work.
> >
> 
> I haven an Supemricro H11DSi-NT with EPYCs CPUs..
> I can set the watchdog ON/OFF in BIOS and also set in to reset or NMI
> with the moatherboard jumpers.
> 
> If you want I can give whatever patches for this driver an try ,
> just let me know.
> 

It would be great if you can test the series, even more so if you can test it
with the watchdog enabled and disabled . If you need to pull it from a git
repository, it is available from
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
in branch watchdog-next.

Thanks,
Guenter

> Regards,
> 
> Gabriel C
