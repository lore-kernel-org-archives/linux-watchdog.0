Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52188 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406AbbG2RHC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 29 Jul 2015 13:07:02 -0400
Message-ID: <55B90833.5020402@roeck-us.net>
Date: Wed, 29 Jul 2015 10:06:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Matt Fleming <matt@codeblueprint.co.uk>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>
Subject: Re: [PATCH v2 3/3] iTCO_wdt: Add support for TCO on Intel Sunrisepoint
References: <1438171844-24861-1-git-send-email-matt@codeblueprint.co.uk> <1438171844-24861-4-git-send-email-matt@codeblueprint.co.uk>
In-Reply-To: <1438171844-24861-4-git-send-email-matt@codeblueprint.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/29/2015 05:10 AM, Matt Fleming wrote:
> From: Matt Fleming <matt.fleming@intel.com>
>
> The revision of the watchdog hardware in Sunrisepoint necessitates a new
> "version" inside the TCO watchdog driver because some of the register
> layouts have changed.
>
> Also update the Kconfig entry to select both the LPC and SMBus drivers
> since the TCO device is on the SMBus in Sunrisepoint.
>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jean Delvare <jdelvare@suse.com>
> Signed-off-by: Matt Fleming <matt.fleming@intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

