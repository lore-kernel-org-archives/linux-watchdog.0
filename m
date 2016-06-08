Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:41473 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423877AbcFHO2m (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 8 Jun 2016 10:28:42 -0400
Subject: Re: [PATCH v3 5/6] watchdog: pretimeout: add panic pretimeout
 governor
To: Wolfram Sang <wsa@the-dreams.de>
References: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1465321127-19522-6-git-send-email-vladimir_zapolskiy@mentor.com>
 <20160608070804.GD1521@katana>
CC: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Robin Gong <b38343@freescale.com>,
	<linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <57582B97.5040402@mentor.com>
Date: Wed, 8 Jun 2016 17:28:39 +0300
MIME-Version: 1.0
In-Reply-To: <20160608070804.GD1521@katana>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

On 08.06.2016 10:08, Wolfram Sang wrote:
> 
>> +static void pretimeout_panic(struct watchdog_device *wdd)
>> +{
>> +	panic("panic on watchdog pretimeout event\n");
>> +}
> 
> And here we have the same redundant message again ("panic on") :( 

I will remove it then.

> Did you look at my patches at all? To me, it looks like you didn't or
> you are intentionally trying to leave my changes out. I don't think they
> were all bad. 

No, they are not, and I'll include some of the changes to v4, if you don't
mind.

> In the previous patch in watchdog_notify_pretimeout() you used 
> the shortened message BTW.

--
With best wishes,
Vladimir
