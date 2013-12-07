Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:38250 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026Ab3LGAs4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Dec 2013 19:48:56 -0500
Date: Fri, 6 Dec 2013 16:48:53 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Doug Anderson <dianders@chromium.org>
Cc: Leela Krishna Amudala <l.krishna@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Tomasz Figa <t.figa@samsung.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"cpgs ." <cpgs@samsung.com>
Subject: Re: [PATCH V12 1/3] ARM: dts: Add pmu sysreg node to exynos5250 and
 exynos5420 dtsi files
Message-ID: <20131207004853.GA2966@roeck-us.net>
References: <1386308868-30264-1-git-send-email-l.krishna@samsung.com>
 <1386308868-30264-2-git-send-email-l.krishna@samsung.com>
 <20131206194709.GA14464@roeck-us.net>
 <CAD=FV=VdcN8rswMABcCZhkhgPjcpngGr+GRS2rsxFaRHwrTuwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=VdcN8rswMABcCZhkhgPjcpngGr+GRS2rsxFaRHwrTuwQ@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Dec 06, 2013 at 03:01:23PM -0800, Doug Anderson wrote:
> Guenter,
> 
> On Fri, Dec 6, 2013 at 11:47 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Fri, Dec 06, 2013 at 11:17:46AM +0530, Leela Krishna Amudala wrote:
> >> This patch adds pmusysreg node to exynos5250 and exynos5420 dtsi files to
> >> handle PMU register accesses in a centralized way using syscon driver
> >>
> >> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> >> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> >> Reviewed-by: Doug Anderson <dianders@chromium.org>
> >> Tested-by: Doug Anderson <dianders@chromium.org>
> >
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> I'm curious of your opinion of Sylwester's requests, since your Ack
> came in after his requests.  Would you like to see a respin of this,
> or do you think it's gone through enough spinning and are thinking it
> would go in as-is?
> 

My Ack means "I am ok with this patch without further changes".
My reaction to the new comments was along the line of "sigh".
Whoever comments now had more than 10 chances to comment earlier,
which should have been way enough, and thus deserves to be ignored.
Sorry if that statement happens to offend any listener, but I am not
really known for my patience.

Guenter
