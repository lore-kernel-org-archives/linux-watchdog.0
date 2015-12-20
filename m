Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58578 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754317AbbLTKkV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 20 Dec 2015 05:40:21 -0500
Subject: Re: [char-misc-next 4/7] watchdog: mei_wdt: add status debugfs entry
To: "Winkler, Tomas" <tomas.winkler@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1450363780-30008-1-git-send-email-tomas.winkler@intel.com>
 <1450363780-30008-5-git-send-email-tomas.winkler@intel.com>
 <56743795.6090700@roeck-us.net>
 <5B8DA87D05A7694D9FA63FD143655C1B540EE5A6@hasmsx108.ger.corp.intel.com>
Cc: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56768591.6060000@roeck-us.net>
Date: Sun, 20 Dec 2015 02:40:17 -0800
MIME-Version: 1.0
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B540EE5A6@hasmsx108.ger.corp.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/20/2015 01:44 AM, Winkler, Tomas wrote:
>
>> On 12/17/2015 06:49 AM, Tomas Winkler wrote:
>>> Add entry for dumping current watchdog internal state
>>>
>>> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
>>> ---
>>>    drivers/watchdog/mei_wdt.c | 84
>> ++++++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 84 insertions(+)
>>>
>>> diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
>>> index 3c97deb70d90..a3f1c1613c32 100644
>>> --- a/drivers/watchdog/mei_wdt.c
>>> +++ b/drivers/watchdog/mei_wdt.c
>>> @@ -16,6 +16,7 @@
>>>    #include <linux/slab.h>
>>>    #include <linux/interrupt.h>
>>>    #include <linux/watchdog.h>
>>> +#include <linux/debugfs.h>
>>>
>>>    #include <linux/uuid.h>
>>>    #include <linux/mei_cl_bus.h>
>>> @@ -54,6 +55,19 @@ enum mei_wdt_state {
>>>    	MEI_WDT_STOPPING,
>>>    };
>>>
>>> +#if IS_ENABLED(CONFIG_DEBUG_FS)
>>> +static const char *mei_wdt_state_str(enum mei_wdt_state state)
>>> +{
>>> +	switch (state) {
>>> +	case MEI_WDT_IDLE: return "IDLE";
>>> +	case MEI_WDT_START: return "START";
>>> +	case MEI_WDT_RUNNING: return "RUNNING";
>>> +	case MEI_WDT_STOPPING: return "STOPPING";
>>> +	default: return "unknown";
>>
>> Doesn't this cause checkpatch warnings ?
> It doesn't and also checkpatch.pl  is just a help tool.

I should have said "Doesn't this violate the single-statement-per-line"
coding style rule, but I guess then you'd argue that "case xxx:" is not
a statement.

Guenter

