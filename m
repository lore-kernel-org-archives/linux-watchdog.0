Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:58283 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848AbaDDPll (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 4 Apr 2014 11:41:41 -0400
Message-ID: <533ED2AE.9010006@roeck-us.net>
Date: Fri, 04 Apr 2014 08:41:34 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Wolfram Sang <wsa@the-dreams.de>,
	Anatolij Gustschin <agust@denx.de>
CC: linux-arm-kernel@lists.infradead.org, Li.Xiubo@freescale.com,
	Shawn Guo <shawn.guo@linaro.org>,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: imx2_wdt: handle enabled watchdog properly
References: <1396623242-15234-1-git-send-email-agust@denx.de> <20140404152011.GC5529@katana>
In-Reply-To: <20140404152011.GC5529@katana>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/04/2014 08:20 AM, Wolfram Sang wrote:
> On Fri, Apr 04, 2014 at 04:54:01PM +0200, Anatolij Gustschin wrote:
>> If the watchdog is already enabled (e.g. started by the boot loader),
>> we need to handle this case properly and start reloading the watchdog
>> time-out counter as frequently as needed.
>>
>> Signed-off-by: Anatolij Gustschin <agust@denx.de>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: Wim Van Sebroeck <wim@iguana.be>
>
> Uh, this driver has not been converted to use the watchdog framework
> yet? I'd suggest this should be the first step.
>

Yes, that would make sense at this time, especially given the amount
of work going into it. There is also a separate patch set pending,
converting the driver to use regmap [1]; I am copying the author.
Maybe one of the people working with the driver would be willing
to do the conversion.

Guenter

[1] http://comments.gmane.org/gmane.linux.kernel/1677735

