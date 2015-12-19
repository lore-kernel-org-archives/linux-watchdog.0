Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53450 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932969AbbLSQVU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 19 Dec 2015 11:21:20 -0500
Subject: Re: [PATCH V5 1/2] watchdog: Use static struct class watchdog_class
 in stead of pointer
To: Pratyush Anand <panand@redhat.com>
References: <cover.1450353452.git.panand@redhat.com>
 <b45250982479cf4a8a59b84bda7c058e424a88e8.1450353452.git.panand@redhat.com>
 <5672CD1B.40105@roeck-us.net> <20151219042208.GH29413@dhcppc13.redhat.com>
Cc: wim@iguana.be, dyoung@redhat.com, dzickus@redhat.com,
	linux-watchdog@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <567583FD.5070303@roeck-us.net>
Date: Sat, 19 Dec 2015 08:21:17 -0800
MIME-Version: 1.0
In-Reply-To: <20151219042208.GH29413@dhcppc13.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/18/2015 08:22 PM, Pratyush Anand wrote:
> On 17/12/2015:06:56:27 AM, Guenter Roeck wrote:
>> On 12/17/2015 04:23 AM, Pratyush Anand wrote:
>>> We need few sysfs attributes to know different status of a watchdog device.
>>> To do that, we need to associate .dev_groups with watchdog_class. So
>>> convert it from pointer to static.
>>> Putting this static struct in watchdog_dev.c, so that static device
>>> attributes defined in that file can be attached to it.
>>>
>>> Signed-off-by: Pratyush Anand <panand@redhat.com>
>>> Suggested-by: Guenter Roeck <linux@roeck-us.net>
>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>
>> As things evolve, I'd by now prefer to move the call to device_create()
>> into watchdog_dev.c, but that can wait for a follow-up patch if Wim
>> is ok with this series.
>
> Thanks for your quick review.
>
> OK. I will wait for Wim's comment and then may be I will send another
> version with your comment for patch 1/1 incorporated.
>

I reworked my patch to call device_create() from watchdog_dev.c on top of
your patches and on top of Wim's watchdog-next branch. Hopefully we can get
that into v4.5.

Guenter

