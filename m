Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54509 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbcGPRSt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 16 Jul 2016 13:18:49 -0400
Subject: Re: Can't query Intel's iTCO watchdog reboot reason
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	dvhart@infradead.org, wim@iguana.be
References: <CAAEAJfAEKvLCk2gjj6MR00t-Yg_-XEG1qb0ij6jse=FV3ez5bw@mail.gmail.com>
Cc: linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <578A6C71.8080705@roeck-us.net>
Date: Sat, 16 Jul 2016 10:18:41 -0700
MIME-Version: 1.0
In-Reply-To: <CAAEAJfAEKvLCk2gjj6MR00t-Yg_-XEG1qb0ij6jse=FV3ez5bw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/15/2016 04:21 PM, Ezequiel Garcia wrote:
> Hi everyone,
>
> A large portion of my intel-based products are suffering from
> a nasty hardware freeze [1], and so I'm currently working this around
> enabling the iTCO watchdog -- which in any case, it's a good idea
> to have enabled.
>
> So, it would be interesting to find out on each boot if the machine was
> rebooted due to a watchdog timeout, but so far I'm not having any luck.
>
> As per Intel's appnote [2] the BIOS should update the WDDT ACPI table,
> so I added something like this to the iTCO driver:
>
>         status = acpi_get_table(ACPI_SIG_WDDT, 1,
>                                 (struct acpi_table_header **) &buf);
>         if (ACPI_FAILURE(status) || buf->header.length < sizeof(*buf)) {
>                 pr_err(FW_BUG "failed to get WDDT ACPI table\n");
>                 return;
>         }
>
> But it doesn't find the table. Strangely, reading TCO1_STS
> and TCO2_STS always gives 0x0.
>

That sounds like either the BIOS resets those bits, or the reboots
are not caused by the watchdog. Are you sure that you see reboots
that are caused by the watchdog ?

Guenter

> Tests were done on a Lynx Point:
>
> [    7.131502] iTCO_wdt: Found a Lynx Point TCO device (Version=2,
> TCOBASE=0x1860)
>
> Any ideas? Is it possible to get this information or should I just gave up?
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=109051
> [2] http://download.intel.com/design/chipsets/applnots/29227301.pdf
>
> Thanks!
>

