Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47304 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbcB2Eku (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 28 Feb 2016 23:40:50 -0500
Subject: Re: [PATCH v7] watchdog: Add watchdog timer support for the
 WinSystems EBC-C384
To: William Breathitt Gray <vilhelm.gray@gmail.com>, wim@iguana.be
References: <20160229042039.GA29582@sophia>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56D3CBD0.1000706@roeck-us.net>
Date: Sun, 28 Feb 2016 20:40:48 -0800
MIME-Version: 1.0
In-Reply-To: <20160229042039.GA29582@sophia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On 02/28/2016 08:20 PM, William Breathitt Gray wrote:
> The WinSystems EBC-C384 has an onboard watchdog timer. The timeout range
> supported by the watchdog timer is 1 second to 255 minutes. Timeouts
> under 256 seconds have a 1 second granularity, while the rest have a 1
> minute granularity.
>
> This driver adds watchdog timer support for this onboard watchdog timer.
> The timeout may be configured via the timeout module parameter.
>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Changes in v7:
>    - Make sure timeout member is in seconds resolution despite minutes
>      granularity
>

For Wim's benefit:

You forgot the actual change. The follow-up RESEND is really confusing;
RESEND indicates that no change was made, and leaves it up to us to figure
out what is going on. If something like this happens again, just add
another rev and add a note indicating what has (really) changed.

Also, when you make code changes, please drop previous Reviewed-by: or
Acked-by: tags unless you got explicit permission from the reviewer
to keep the tag.

Thanks,
Guenter

