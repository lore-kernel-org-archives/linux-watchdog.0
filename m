Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40354 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503AbbFBNqZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 2 Jun 2015 09:46:25 -0400
Message-ID: <556DB3AF.6050105@roeck-us.net>
Date: Tue, 02 Jun 2015 06:46:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: imx2_wdt: set watchdog parent device
References: <1433249178-30779-1-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1433249178-30779-1-git-send-email-vladimir_zapolskiy@mentor.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/02/2015 05:46 AM, Vladimir Zapolskiy wrote:
> If on watchdog device registration a parent device is not set, then
> the registered watchdog is considered to be a virtual device:
>
>    /sys/devices/virtual/watchdog/watchdog0
>    /sys/devices/virtual/watchdog/watchdog1
>
> Setting a correct reference to a platform device allows to
> distinguish multiple instances of iMX2+ hardware watchdogs:
>
>    /sys/devices/soc0/soc/2000000.aips-bus/20bc000.wdog/watchdog/watchdog0
>    /sys/devices/soc0/soc/2000000.aips-bus/20c0000.wdog/watchdog/watchdog1
>
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


