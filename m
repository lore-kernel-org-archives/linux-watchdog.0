Return-path: <panand@redhat.com>
Date: Wed, 26 Aug 2015 04:49:17 +0530
From: Pratyush Anand <panand@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, dyoung@redhat.com, dzickus@redhat.com,
        open list:  ABI/API <linux-api@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH RFC] watchdog: Add watchdog device control through sysfs
 attributes
Message-ID: <20150825231917.GD13340@dhcppc13.redhat.com>
References: <d9ac417a3bc1c6846f1ddfcd3cd07e5a92865c19.1440179209.git.panand@redhat.com>
 <20150825164559.GC13340@dhcppc13.redhat.com>
 <55DCA3C1.5050307@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55DCA3C1.5050307@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On 25/08/2015:10:20:01 AM, Guenter Roeck wrote:
> On 08/25/2015 09:45 AM, Pratyush Anand wrote:
> >Hi Guenter,
> >
> >On 21/08/2015:11:18:12 PM, Pratyush Anand wrote:
> >>This patch adds following attributes to watchdog device's sysfs interface.
> >
> >Please see if you can review it.
> >
> >Does this patch look fine to you? If yes then do I need to resend it by removing
> >RFC tag.
> >
> 
> I didn't have time to review your patch in detail. Sorry, but please keep in mind
> that this is all volunteer work for me.

It's understandable. Sorry for my impatience. Please take your time.

> 
> I don't feel comfortable with modifying the watchdog state through sysfs.
> That changes the ABI substantially, since it is no longer necessary to have
> an application to activate the watchdog. It also messes up internal state keeping,
> since there is now no longer a well defined state indicating that the kernel
> expects user space to send heartbeats, or if the kernel needs to do it (in the
> driver or, with the patch set I submitted a couple of weeks ago, in the watchdog
> core).

I will be OK with removing 'start'.

> 
> Given that, and I really don't have time to look into it more deeply,
> I put the whole thing on a back burner for now.
> 

No issue, will wait :-)

~Pratyush
