Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40636 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbbLUX2l (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 21 Dec 2015 18:28:41 -0500
Subject: Re: [PATCH 1/5] watchdog: Create watchdog device in watchdog_dev.c
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Pratyush Anand <panand@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org
References: <1450645503-16661-1-git-send-email-linux@roeck-us.net>
 <1450645503-16661-2-git-send-email-linux@roeck-us.net>
 <20151221173123.GD12696@localhost>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56788B27.20706@roeck-us.net>
Date: Mon, 21 Dec 2015 15:28:39 -0800
MIME-Version: 1.0
In-Reply-To: <20151221173123.GD12696@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/21/2015 09:31 AM, Damien Riegel wrote:
> On Sun, Dec 20, 2015 at 01:04:59PM -0800, Guenter Roeck wrote:
>> The watchdog character device is currently created in watchdog_dev.c,
>> and the watchdog device in watchdog_core.c. This results in
>> cross-dependencies, since device creation needs to know the watchdog
>> character device number as well as the watchdog class, both of which
>> reside in watchdog_dev.c.
>>
>> Create the watchdog device in watchdog_dev.c to simplify the code.
>>
>> Inspired by earlier patch set from Damien Riegel.
>
> Hi Guenter,
>
> The main purpose of my patch was to inverse the device creation and the
> cdev registration to avoid a racy situation, bu you have dropped that in
> this version. Is there a reason for that?
>
Every other driver I looked at does it in the same order (cdev first, device
second). I don't really know if doing it differently has any undesired
side effect, so I wanted to play safe.

It would help a lot if someone listening to this exchange can confirm
that it is ok to create the device first, followed by the character device.

Thanks,
Guenter

