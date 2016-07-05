Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42146 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755294AbcGEPlH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 5 Jul 2016 11:41:07 -0400
Subject: Re: [PATCH 0/6] Implement I2C restart handler
To: Wolfram Sang <wsa@the-dreams.de>,
	Stefan Christ <s.christ@phytec.de>
References: <1467724943-13416-1-git-send-email-s.christ@phytec.de>
 <20160705145839.GA3641@tetsubishi>
Cc: linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <577BD510.1070506@roeck-us.net>
Date: Tue, 5 Jul 2016 08:41:04 -0700
MIME-Version: 1.0
In-Reply-To: <20160705145839.GA3641@tetsubishi>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/05/2016 07:58 AM, Wolfram Sang wrote:
> Hi,
>
>> this is a request for feedback about a lockdep-warning-free I2C
>> restart_handler.  I would like to know whether someone had the problem already
>> and how the best and mainline friendliest solution looks like.
>> I have an embedded board with the PMIC chip DA9063 that is also used as a
>> voltage regulator for DVFS. For a clean reboot/reset of the system I have to
>> set the bit nSHUTDOWN in the PMIC via I2C. The restart_handler call chain
>> is of type
>>
>>      static ATOMIC_NOTIFIER_HEAD(restart_handler_list);
>>
>> So any code running as a restart_handler cannot (should not) wait, for other
>> locks. When you use i2c_transfer/regmap you get lockdep warnings like [1].
>
> Yes, this problem has come up occasionally. And it is not only about
> sleeping. IRQs are disabled, too.
>
> My idea was to introduce master_xfer_irqless or similar to struct
> i2c_algorithm. I even discussed this shortly with Mark Brown how to
> interact with regmap; but this was too long ago, so I forgot what we
> agreed on :(
>
>> Any comments?
>
> I just skimmed very lightly over the patchset. Yet, seeing an I2C client
> messing directly with 'struct adapter' breaks so many abstractions, it
> hits my instant-NACK nerve ;)
>

My NACK would be for two other reasons: First, for bypassing the watchdog core
for handling the minimum time between heartbeats, second for bypassing
the watchdog core to implement a reboot handler. Both are inadequately
or not at all explained.

Guenter

