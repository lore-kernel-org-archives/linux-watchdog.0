Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:42121 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161864AbcFHOcS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 8 Jun 2016 10:32:18 -0400
Subject: Re: [PATCH v3 6/6] watchdog: pretimeout: add noop pretimeout governor
To: Wolfram Sang <wsa@the-dreams.de>
References: <1465321127-19522-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1465321127-19522-7-git-send-email-vladimir_zapolskiy@mentor.com>
 <20160608071001.GE1521@katana>
CC: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Robin Gong <b38343@freescale.com>,
	<linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <57582C6E.1000305@mentor.com>
Date: Wed, 8 Jun 2016 17:32:14 +0300
MIME-Version: 1.0
In-Reply-To: <20160608071001.GE1521@katana>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08.06.2016 10:10, Wolfram Sang wrote:
>> +static void pretimeout_noop(struct watchdog_device *wdd)
>> +{
>> +	pr_alert("watchdog pretimeout event\n");
>> +}
> 
> My version said which watchdog caused the event, why not adding that?
> 

I will add it. It's a bit sad that a virtual volatile id is reported,
but it is better than nothing...

Best wishes,
Vladimir
