Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40054 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755704AbbEUP2m (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 May 2015 11:28:42 -0400
Date: Thu, 21 May 2015 08:28:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Timur Tabi <timur@codeaurora.org>
Cc: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com,
	linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, tekkamanninja@gmail.com,
	graeme.gregory@linaro.org, al.stone@linaro.org,
	hanjun.guo@linaro.org, ashwin.chaugule@linaro.org, arnd@arndb.de,
	vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
	leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
Message-ID: <20150521152838.GB16668@roeck-us.net>
References: <=fu.wei@linaro.org>
 <1432197156-16947-1-git-send-email-fu.wei@linaro.org>
 <1432197156-16947-7-git-send-email-fu.wei@linaro.org>
 <555DB4C4.5090606@roeck-us.net>
 <555DD8EE.1060607@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <555DD8EE.1060607@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, May 21, 2015 at 08:09:02AM -0500, Timur Tabi wrote:
> Guenter Roeck wrote:
> >>
> >>+static unsigned int sbsa_gwdt_get_timeleft(struct watchdog_device *wdd)
> >>+{
> >>+    struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
> >>+    u64 timeleft = sbsa_gwdt_get_wcv(wdd) - arch_counter_get_cntvct();
> >>+
> >
> >Still not happy about the use of arch_counter_get_cntvct
> >instead of using the clock subsystem. I am quite sure this could be done,
> >possibly through arch_sys_counter, though at this point I am getting wary
> >of bringing it up, so I guess I'll just let it go.
> 
> You made the same comment with my driver, and I keep asking for
> clarification.  The clk_get_sys() API does not work on my system, because
> there are not clocks defined.  That must be an ACPI limitation that I can't
> fix.
> 
Would it be possible to define such clocks ?

> The alternative to arch_counter_get_cntvct() is arch_timer_read_counter(),
> which is not exported.  So we have two choices,
> 
> 1) Continue to use arch_counter_get_cntvct(), which works on all ARM64
> platforms that this driver supports anyway
> 
> 2) Export arch_timer_read_counter()
> 
> I prefer option #1.
> 
Do we have any feedback from the arm maintainers ?

My problem is that I don't want to be the first one to permit using
those functions outside architecture and clock code. If we do this,
we should get an Ack from an arm maintainer specifically for the use
of arch_counter_get_cntvct() and arch_timer_get_rate().

Thanks,
Guenter
