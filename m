Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52021 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212AbbG2RGc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 29 Jul 2015 13:06:32 -0400
Message-ID: <55B90814.3080704@roeck-us.net>
Date: Wed, 29 Jul 2015 10:06:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Matt Fleming <matt@codeblueprint.co.uk>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
	Matt Fleming <matt.fleming@intel.com>
Subject: Re: [PATCH v2 2/3] i2c: i801: Create iTCO device on newer Intel PCHs
References: <1438171844-24861-1-git-send-email-matt@codeblueprint.co.uk> <1438171844-24861-3-git-send-email-matt@codeblueprint.co.uk>
In-Reply-To: <1438171844-24861-3-git-send-email-matt@codeblueprint.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/29/2015 05:10 AM, Matt Fleming wrote:
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> Starting from Intel Sunrisepoint (Skylake PCH) the iTCO watchdog resources
> have been moved to reside under the i801 SMBus host controller whereas
> previously they were under the LPC device.
>
> In order to support the iTCO watchdog on newer PCHs we need to create the
> platform device here in the SMBus driver and pass all known resources using
> platform data.
>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: <linux-i2c@vger.kernel.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Matt Fleming <matt.fleming@intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

