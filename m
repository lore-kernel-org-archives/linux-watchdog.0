Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34005 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbbG1PTC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jul 2015 11:19:02 -0400
Message-ID: <55B79D60.4080807@roeck-us.net>
Date: Tue, 28 Jul 2015 08:18:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>,
	Matt Fleming <matt@codeblueprint.co.uk>
CC: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Aaron Sierra <asierra@xes-inc.com>
Subject: Re: [PATCH 1/5] iTCO_wdt: Expose watchdog properties using platform
 data
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk> <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk> <20150728094643.GT14943@x1> <20150728110717.GH2492@codeblueprint.co.uk> <20150728113721.GU14943@x1> <20150728124338.GA2773@codeblueprint.co.uk> <20150728150021.GX14943@x1>
In-Reply-To: <20150728150021.GX14943@x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/28/2015 08:00 AM, Lee Jones wrote:
> On Tue, 28 Jul 2015, Matt Fleming wrote:
>> On Tue, 28 Jul, at 12:37:21PM, Lee Jones wrote:
>>>
>>> The driver shouldn't be called that either.
>>>
>>> You are the only one.  What makes iTCO 'special'?
>>
>> I don't know, I didn't write it. It looks like Wim did ~9 years ago, so
>> it must have made sense to him at the time.
>>

Coding style wasn't as strict then as it is today. iTCO has just been kept
for historic reasons.

Sure, we could have changed it to lowercase, but so far no one bothered.
Plus, of course, there is always the element that some maintainers hate
that kind of cleanup, and patch submitters like Matt are stuck between
a rock and a hard place.

Guenter

