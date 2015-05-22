Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37832 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756607AbbEVPQU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 22 May 2015 11:16:20 -0400
Date: Fri, 22 May 2015 08:16:16 -0700
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
Subject: Re: [PATCH v2 1/7] clocksource: export "arch_timer_get_rate" for the
 other drivers
Message-ID: <20150522151616.GA3272@roeck-us.net>
References: <=fu.wei@linaro.org>
 <1432197156-16947-1-git-send-email-fu.wei@linaro.org>
 <1432197156-16947-2-git-send-email-fu.wei@linaro.org>
 <555F3886.9020506@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <555F3886.9020506@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, May 22, 2015 at 09:09:10AM -0500, Timur Tabi wrote:
> fu.wei@linaro.org wrote:
> >Some devices get clock from system counter, like SBSA watchdog
> >driver. They may need to get system counter rate.
> 
> We don't need this patch.  The watchdog driver can use
> arch_timer_get_cntfrq() instead of arch_timer_get_rate().  There's nothing
> wrong with arch_timer_get_cntfrq() since the SBSA driver is intended only
> for ARM64 server systems, and arch_timer_get_cntfrq() is always defined for
> such systems.
> 
I agree, since the SBSA driver also uses arch_counter_get_cntvct()
which is declared in the same include file as arch_timer_get_cntfrq().
The additional dependency does not provide any value, unless architecture
implementation dependencies can be removed entirely, which does not seem
to be the case.

Doo bad that SBSA is not hardware independent enough to provide all
the information needed to implement such a driver :-(.

Guenter
