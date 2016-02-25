Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41870 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbcBYRNH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 25 Feb 2016 12:13:07 -0500
Subject: Re: [PATCH v3] watchdog: ni903x_wdt: Add NI 903x/913x watchdog driver
To: Kyle Roeschley <kyle.roeschley@ni.com>, wim@iguana.be
References: <1456154903-22271-1-git-send-email-kyle.roeschley@ni.com>
Cc: linux-watchdog@vger.kernel.org, joshc@ni.com, david.madden@ni.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56CF361E.7010505@roeck-us.net>
Date: Thu, 25 Feb 2016 09:13:02 -0800
MIME-Version: 1.0
In-Reply-To: <1456154903-22271-1-git-send-email-kyle.roeschley@ni.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/22/2016 07:28 AM, Kyle Roeschley wrote:
> Add support for the watchdog timer on NI cRIO-903x and cDAQ-913x real-
> time controllers.
>
> Signed-off-by: Jeff Westfahl <jeff.westfahl@ni.com>
> Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
> ---
> v3: Rename ni9x3x_wdt -> ni903x_wdt
>      Remove 64-bit rounding workarounds
>      Add WDIOF_MAGICCLOSE
>      Cleanup ACPI resource walking
>      Fixup acpi_add error handling
>      Cleanup includes, formatting, license/copyright
>
> v2: Rename niwatchdog -> ni9x3x_wdt
>      Drop custom IOCTLs
>      Remove locking, io_size, expired, running, available
>      Remove all IRQ code
>      Fix error handling in acpi_add
>      Remove unnecessary header file
>
>   Documentation/watchdog/watchdog-parameters.txt |   5 +
>   drivers/watchdog/Kconfig                       |  11 +
>   drivers/watchdog/Makefile                      |   1 +
>   drivers/watchdog/ni903x_wdt.c                  | 270 +++++++++++++++++++++++++
>   4 files changed, 287 insertions(+)
>   create mode 100644 drivers/watchdog/ni903x_wdt.c
>
> diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
> index 9f9ec9f..df3e20e 100644
> --- a/Documentation/watchdog/watchdog-parameters.txt
> +++ b/Documentation/watchdog/watchdog-parameters.txt
> @@ -200,6 +200,11 @@ mv64x60_wdt:
>   nowayout: Watchdog cannot be stopped once started
>   	(default=kernel config parameter)
>   -------------------------------------------------
> +ni903x_wdt:
> +timeout: Intial watchdog timeout in seconds (0<timeout<516, default=60)

s/Intial/Initial/

checkpatch is your friend here.

Please fix and resubmit, and feel free to add

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

when you do.

Thanks,
Guenter

