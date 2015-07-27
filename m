Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53633 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbbG0OYM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jul 2015 10:24:12 -0400
Message-ID: <55B63F09.4030101@roeck-us.net>
Date: Mon, 27 Jul 2015 07:24:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Matt Fleming <matt@codeblueprint.co.uk>
CC: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] iTCO_wdt: Expose watchdog properties using platform
 data
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk> <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk> <55B636D4.6020709@roeck-us.net> <20150727141948.GA2677@codeblueprint.co.uk>
In-Reply-To: <20150727141948.GA2677@codeblueprint.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/27/2015 07:19 AM, Matt Fleming wrote:
> On Mon, 27 Jul, at 06:49:08AM, Guenter Roeck wrote:
>>
>> I don't see the platform data freed anywhere, neither in the error path nor
>> in the cleanup path of this driver. Can you use devm_kzalloc() ?
>> Otherwise I think you'll need a cleanup path.
>
> Oops, good catch. Yes, devm_kzalloc() can be used here, thanks!
>
Or maybe just use a static data structure, like in the i2c driver.

Guenter

