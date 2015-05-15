Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41173 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754948AbbEOSBI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 May 2015 14:01:08 -0400
Date: Fri, 15 May 2015 11:01:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Fu Wei <fu.wei@linaro.org>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Timur Tabi <timur@codeaurora.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>
Subject: Re: [PATCH 4/6] Watchdog: introdouce "pretimeout" into framework
Message-ID: <20150515180105.GB19230@roeck-us.net>
References: <=fu.wei@linaro.org>
 <1431689090-3125-1-git-send-email-fu.wei@linaro.org>
 <5555F5C5.8050806@roeck-us.net>
 <CADyBb7sC5a6vC6CqQsfCqOaxz1P8gKNkZi5qEHtXL7efv42-=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyBb7sC5a6vC6CqQsfCqOaxz1P8gKNkZi5qEHtXL7efv42-=Q@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, May 15, 2015 at 09:49:07PM +0800, Fu Wei wrote:
> Hi Guenter,
> 
> Great thanks for your review,
> feedback inline below :-)
> 
> On 15 May 2015 at 21:33, Guenter Roeck <linux@roeck-us.net> wrote:

[ ... ]

> >> +       if (wdd->max_pretimeout && wdd->max_timeout < wdd->max_pretimeout)
> >> {
> >> +               pr_info("Invalid max timeout, resetting to max
> >> pretimeout!\n");
> >> +               wdd->max_timeout = wdd->max_pretimeout;
> >> +       }
> >
> >
> > I am a bit concerned about the context dependency introduced here. If
> > someone calls
> > _init_pretimeout after calling init_timeout, this may result in still
> > invalid timeout
> > values.
> 
> yes, that logic is not very clean, so my thought is :
> maybe we can integrate watchdog_init_timeout and watchdog_init_pretimeout,
> if maintainer agree to add pretimeout into framework.
> 
I think we should just assume that Wim will accept it, and try to find
the best possible solution (or at least a good one).

Guenter
