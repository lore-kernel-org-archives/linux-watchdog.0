Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40345 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752961AbbFCSZK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 3 Jun 2015 14:25:10 -0400
Date: Wed, 3 Jun 2015 11:25:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Timur Tabi <timur@codeaurora.org>
Cc: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com,
	linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, tekkamanninja@gmail.com,
	graeme.gregory@linaro.org, al.stone@linaro.org,
	hanjun.guo@linaro.org, ashwin.chaugule@linaro.org, arnd@arndb.de,
	vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
	leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com,
	catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net
Subject: Re: [PATCH v4 5/7] Watchdog: introduce ARM SBSA watchdog driver
Message-ID: <20150603182503.GD6460@roeck-us.net>
References: <=fu.wei@linaro.org>
 <1433217907-928-1-git-send-email-fu.wei@linaro.org>
 <1433217907-928-6-git-send-email-fu.wei@linaro.org>
 <556F4489.6030206@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <556F4489.6030206@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jun 03, 2015 at 01:16:41PM -0500, Timur Tabi wrote:
> On 06/01/2015 11:05 PM, fu.wei@linaro.org wrote:
> >+	if (wdd->pretimeout)
> >+		/* The pretimeout is valid, go panic */
> >+		panic("SBSA Watchdog pre-timeout");
> 
> The problem with this is that WS1 will still occur.  So a few seconds after
> the panic() call, the hardware will reset.  There won't be any time to debug
> or log anything.
> 

In general the idea here would be to use a crashdump kernel, which,
when loaded, would reset the watchdog before it fires. This kernel
would then write a core dump to a specified location. 

If arm64 doesn't support a crashdump kernel, it might still be possible
to log the backtrace somewhere (eg in nvram using pstore if that is
supported via acpi or efi).

Is there reason to believe that this all won't work on arm64 ?

Thanks,
Guenter
