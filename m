Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58620 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932111AbcFHNxl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 8 Jun 2016 09:53:41 -0400
Subject: Re: [PATCH v3 4/6] watchdog: add watchdog pretimeout framework
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
References: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1465321127-19522-5-git-send-email-vladimir_zapolskiy@mentor.com>
 <20160607214309.GA17129@roeck-us.net> <57581FB2.10806@mentor.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Wolfram Sang <wsa@the-dreams.de>,
	Robin Gong <b38343@freescale.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <57582363.8050406@roeck-us.net>
Date: Wed, 8 Jun 2016 06:53:39 -0700
MIME-Version: 1.0
In-Reply-To: <57581FB2.10806@mentor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/08/2016 06:37 AM, Vladimir Zapolskiy wrote:

>>>
>>> +comment "Watchdog Pretimeout Governors"
>>> +
>>> +config WATCHDOG_PRETIMEOUT_GOV
>>> +	bool "Enable watchdog pretimeout governors"
>>> +	default n
>>
>> I don't think 'default n" is needed.
>>
>
> No strict objections, but probably 'default n' may save quite many
> lines in defconfigs.
>

I always wondered why it would be necessary to say "default n".
What is the difference between "default n" and no explicit default ?

Guenter

