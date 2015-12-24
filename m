Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55728 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbbLXP0C (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 24 Dec 2015 10:26:02 -0500
Subject: Re: [PATCH 0/5] watchdog: Do not use 'dev' from watchdog_device in
 watchdog drivers
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
References: <1450933893-7761-1-git-send-email-linux@roeck-us.net>
 <20151224150744.GA6463@localhost>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <567C0E87.7020007@roeck-us.net>
Date: Thu, 24 Dec 2015 07:25:59 -0800
MIME-Version: 1.0
In-Reply-To: <20151224150744.GA6463@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/24/2015 07:07 AM, Damien Riegel wrote:
> On Wed, Dec 23, 2015 at 09:11:28PM -0800, Guenter Roeck wrote:
>> The 'dev' variable in watchdog drivers has a different lifetime than the
>> watchdog character device and should therefore not be used by watchdog
>> drivers.
>>
>> Some of the drivers use the variable to print kernel messages. Those are
>> either dropped or converted to use pr_ functions. One driver sets the
>> variable during initialization to the watchdog driver's parent device,
>> which is wrong and also removed.
>
> Hi Guenter,
>
> For gpio_wdt and mena21_wdt, wdd->parent is set and could be used for
> dev_* printings. Do you prefer to keep this variable only for watchdog
> core internal usage? Otherwise, the serie looks good.
>
Good idea, I'll use ->parent for those. ->parent is set by the driver,
so it is safe to be used by the driver.

Thanks,
Guenter

