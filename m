Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:33737 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbcBVTQb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Feb 2016 14:16:31 -0500
Received: by mail-yw0-f174.google.com with SMTP id u200so127436519ywf.0
        for <linux-watchdog@vger.kernel.org>; Mon, 22 Feb 2016 11:16:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1456166636.4629.119.camel@chaos.site>
References: <20160222121132.665b1f77@endymion>
	<56CB1FE5.8080206@roeck-us.net>
	<CAJx26kWTo9OEZ-FCPMwE4t+=zZNf5d97sDRTx-FibEf92Tg--w@mail.gmail.com>
	<1456166636.4629.119.camel@chaos.site>
Date: Mon, 22 Feb 2016 11:16:30 -0800
Message-ID: <CAJx26kWE7NFeppXL_DM+O7XiZdswQW=iwfZbbPCUqr5PEvGtDg@mail.gmail.com>
Subject: Re: [PATCH] watchdog: Add hardware dependency to BCM7038 driver
From: Justin Chen <justinpopo6@gmail.com>
To: Jean Delvare <jdelvare@suse.de>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Feb 22, 2016 at 10:43 AM, Jean Delvare <jdelvare@suse.de> wrote:
> Hello Justin,
>
> Le Monday 22 February 2016 à 09:58 -0800, Justin Chen a écrit :
>> This driver is based off of a Broadcom watchdog block, it is not tied
>> to the MIPS core.
>> The watchdog driver is named BCM7038 because that was the first chip
>> that featured this watchdog block. Their are other chips that use this
>> driver that are not MIPS based.
>
> The Kconfig help text doesn't say this at all. With the current wording
> there is no reason why anyone would enable this option if not building a
> kernel for the Broadcom BCM7038.
Sorry about that! I can submit a patch to fix this.
>
> Which other systems reuse this watchdog block exactly? In the kernel
> tree I can't see anyone instantiating this device.
BRCMSTB chips use this block as well as other BCM chips.

"This driver is for a watchdog block contained in all Broadcom Set-top
Box chips since BCM7038. BCM7038 was made public during the 2004 CES,
and since then, many chips use this watchdog block including some cable
modem chips."
>
> --
> Jean Delvare
> SUSE L3 Support
>
