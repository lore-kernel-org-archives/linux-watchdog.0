Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60180 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932167AbcFINd5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 9 Jun 2016 09:33:57 -0400
Subject: Re: [PATCH V3] watchdog: max77620: Add support for watchdog timer
To: Laxman Dewangan <ldewangan@nvidia.com>, wim@iguana.be
References: <1465393148-24890-1-git-send-email-ldewangan@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <57597032.8040008@roeck-us.net>
Date: Thu, 9 Jun 2016 06:33:38 -0700
MIME-Version: 1.0
In-Reply-To: <1465393148-24890-1-git-send-email-ldewangan@nvidia.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/08/2016 06:39 AM, Laxman Dewangan wrote:
> Maxim PMIC MAX77620 is Power management IC which have multiple
> sub blocks like regulators (DCDC/LDOs), GPIO, RTC, Clock, Watchdog
> timer etc.
>
> Add the driver for watchdog timer under watchdog framework.
> The driver implements the watchdog callbacks to start, stop,
> ping and set timeout for watchodg framework.
>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

Mostly good.

[ ... ]

> +	/* Check if WDT running and ig yes then set flags properly */

s/ig/if/

Please fix this up and resend, with

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Can you by any chance send me a copy of the datasheet ? I wanted to look up the
chip default for the watchdog timeout and realized that the chip does not
officially exist.

Thanks,
Guenter

