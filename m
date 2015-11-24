Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45942 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbbKXCcX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Nov 2015 21:32:23 -0500
Subject: Re: [PATCH v4 3/5] watchdog: ts4800: add driver for TS-4800 watchdog
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
References: <1448291861-28543-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1448291861-28543-4-git-send-email-damien.riegel@savoirfairelinux.com>
Cc: Lee Jones <lee.jones@linaro.org>, robh+dt@kernel.org,
	shawnguo@kernel.org, kernel@pengutronix.de, wim@iguana.be,
	sameo@linux.intel.com, dinh.linux@gmail.com,
	Arnd Bergmann <arnd@arndb.de>, kernel@savoirfairelinux.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5653CC2F.8080608@roeck-us.net>
Date: Mon, 23 Nov 2015 18:32:15 -0800
MIME-Version: 1.0
In-Reply-To: <1448291861-28543-4-git-send-email-damien.riegel@savoirfairelinux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Damien,

On 11/23/2015 07:17 AM, Damien Riegel wrote:
> This watchdog is instantiated in a FPGA that is memory mapped. It is
> made of only one register, called the feed register. Writing to this
> register will re-arm the watchdog for a given time (and enable it if it
> was disable). It can be disabled by writing a special value into it.
>
> It is part of a syscon block, and the watchdog register offset in this
> block varies from board to board. This offset is passed in the syscon
> property after the phandle to the syscon node.
>
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> ---

[ ... ]

> +
> +static int ts4800_wdt_set_timeout(struct watchdog_device *wdd,
> +				  unsigned int timeout)
> +{
> +	struct ts4800_wdt *wdt = watchdog_get_drvdata(wdd);
> +	int i;
> +
> +	for (i = 0; i <= MAX_TIMEOUT_INDEX; i++) {
> +		if (ts4800_wdt_map[i].timeout >= timeout)
> +			break;
> +	}

If the loop does not break, i will have a value of MAX_TIMEOUT_INDEX + 1,
or 2, pointing after the end of the table. That should never happen,
but still ...

I preferred the earlier version, where you had an extra function.
Only my suggestion was to have that function return MAX_TIMEOUT_INDEX
instead of an error. Alternatively, the check above needs to be
"i < MAX_TIMEOUT_INDEX".

Guenter

