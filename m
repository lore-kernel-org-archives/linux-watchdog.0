Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:53101 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753436AbcH2T7d (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 29 Aug 2016 15:59:33 -0400
Subject: Re: [PATCH v4 1/7] watchdog: add pretimeout support to the core
To: Wolfram Sang <wsa@the-dreams.de>
References: <1472227681-1405-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1472227681-1405-2-git-send-email-vladimir_zapolskiy@mentor.com>
 <20160829185005.GD1610@katana>
CC: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Robin Gong <b38343@freescale.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <e9c4fb76-5b26-ab1e-09a3-d1af57451203@mentor.com>
Date: Mon, 29 Aug 2016 22:58:57 +0300
MIME-Version: 1.0
In-Reply-To: <20160829185005.GD1610@katana>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/29/2016 09:50 PM, Wolfram Sang wrote:
>> +	} else {
>>  		wdd->timeout = timeout;
>> +		/* Disable pretimeout if it doesn't fit the new timeout */
>> +		if (wdd->pretimeout >= wdd->timeout)
>> +			wdd->pretimeout = 0;
>
> I wonder if we should add a warning here? What do you think?
>

IMHO it is not vitally needed, but some message on KERN_INFO level may
be considered as user-friendly, watchdog subsystem and drivers are
historically verbose. Guenter, do you have an opinion on the topic?

I also note that this runtime behaviour is properly described in
the collateral documentation change.

--
With best wishes,
Vladimir
