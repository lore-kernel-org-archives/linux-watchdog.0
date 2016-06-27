Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42205 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbcF0Nct (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jun 2016 09:32:49 -0400
Subject: Re: [PATCH v2 1/2] watchdog: add pretimeout support to the core
To: Wolfram Sang <wsa@the-dreams.de>
References: <1466902865-14354-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1466902865-14354-2-git-send-email-vladimir_zapolskiy@mentor.com>
 <576F3E2E.7060606@roeck-us.net> <20160627093707.GD1602@katana>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Robin Gong <b38343@freescale.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <57712AF4.80104@roeck-us.net>
Date: Mon, 27 Jun 2016 06:32:36 -0700
MIME-Version: 1.0
In-Reply-To: <20160627093707.GD1602@katana>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/27/2016 02:37 AM, Wolfram Sang wrote:
>
>> Nitpick: If we consider pretimeout == timeout to be invalid, we should reject it here
>> as well. So this should be >=.
>
> I agree to that.
>
>> to the next version. I'd suggest to wait a bit to give Wolfram time to provide input,
>> though.
>
> I liked the is_visible() change right away, so these patches are fine.
> Guenter, what is your take on upstreaming the softdog pretimeout
> support? I'd think it would be good to have for testing purposes. It
> would also help me to upstream the busybox patch for the watchdog
> applet.
>

Sure, but the current patch series doesn't include watchdog_notify_pretimeout(),
or am I missing something ?

Guenter

