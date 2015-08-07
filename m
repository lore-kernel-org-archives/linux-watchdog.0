Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58150 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932459AbbHGQ1L (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Aug 2015 12:27:11 -0400
Message-ID: <55C4DC58.5030602@roeck-us.net>
Date: Fri, 07 Aug 2015 09:27:04 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt@codeblueprint.co.uk>
CC: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Lee Jones <lee.jones@linaro.org>,
	Darren Hart <dvhart@infradead.org>, linux-i2c@vger.kernel.org,
	Matt Fleming <matt.fleming@intel.com>
Subject: Re: [PATCH v4 2/3] i2c: i801: Create iTCO device on newer Intel PCHs
References: <1438865186-25794-1-git-send-email-matt@codeblueprint.co.uk> <1438865186-25794-3-git-send-email-matt@codeblueprint.co.uk> <20150807155535.GA25357@katana>
In-Reply-To: <20150807155535.GA25357@katana>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/07/2015 08:55 AM, Wolfram Sang wrote:
> On Thu, Aug 06, 2015 at 01:46:25PM +0100, Matt Fleming wrote:
>> From: Mika Westerberg <mika.westerberg@linux.intel.com>
>>
>> Starting from Intel Sunrisepoint (Skylake PCH) the iTCO watchdog resources
>> have been moved to reside under the i801 SMBus host controller whereas
>> previously they were under the LPC device.
>>
>> In order to support the iTCO watchdog on newer PCHs we need to create the
>> platform device here in the SMBus driver and pass all known resources using
>> platform data.
>>
>> Cc: Jean Delvare <jdelvare@suse.com>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: <linux-i2c@vger.kernel.org>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Signed-off-by: Matt Fleming <matt.fleming@intel.com>
>
> Dunno which tree this should go through (probably MFD or watchdog), but
> doesn't look like I2C, so:
>

Probably watchdog ?

Guenter


