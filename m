Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42374 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324AbcEROhF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 May 2016 10:37:05 -0400
Subject: Re: [PATCH 2/2] x86: Fix Apollo Lake Watchdog address in PMC driver
To: "Yong, Jonathan" <jonathan.yong@intel.com>,
	linux-watchdog@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <1463541972-19758-1-git-send-email-jonathan.yong@intel.com>
 <1463541972-19758-3-git-send-email-jonathan.yong@intel.com>
 <573BE985.1000306@roeck-us.net> <573BF421.2020503@intel.com>
Cc: qipeng.zha@intel.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <573C7E0C.7050304@roeck-us.net>
Date: Wed, 18 May 2016 07:37:00 -0700
MIME-Version: 1.0
In-Reply-To: <573BF421.2020503@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/17/2016 09:48 PM, Yong, Jonathan wrote:
> On 05/18/2016 12:03, Guenter Roeck wrote:
>> On 05/17/2016 08:26 PM, Yong, Jonathan wrote:
>>> The TCO I/O base is 40h rather than the usual 30h, and the
>>> re_reboot bit is at ACPIBASE+8.
>>>
>>
>> Does this mean that the code never worked, or in other words that it
>> was never tested, or are there now other chips which used the old
>> definitions which no longer work after this patch has been applied ?
>
> To my knowledge, it has never worked since 30h is claimed by ACPI GPE0_BLK.
>
Hmm.. Darren will have to take that one. I am not in a position to
determine if the new patch is correct or not, and/or if it causes some
other platform/architecture to fail. I'll Ack the other patch, and
would suggest for Darren to take it as well to keep the two patches together.

Guenter

> With this patch, watchdog ioctl is working properly with WDIOC_SETTIMEOUT, WDIOC_GETTIMEOUT and WDIOC_GETTIMELEFT as expected.
>

