Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:36755 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755903AbcBWA1x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Feb 2016 19:27:53 -0500
Received: by mail-yw0-f169.google.com with SMTP id e63so133475978ywc.3
        for <linux-watchdog@vger.kernel.org>; Mon, 22 Feb 2016 16:27:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160223001607.GB1215@roeck-us.net>
References: <20160222121132.665b1f77@endymion>
	<56CB1FE5.8080206@roeck-us.net>
	<CAJx26kWTo9OEZ-FCPMwE4t+=zZNf5d97sDRTx-FibEf92Tg--w@mail.gmail.com>
	<1456166636.4629.119.camel@chaos.site>
	<CAJx26kWE7NFeppXL_DM+O7XiZdswQW=iwfZbbPCUqr5PEvGtDg@mail.gmail.com>
	<20160223001607.GB1215@roeck-us.net>
Date: Mon, 22 Feb 2016 16:27:52 -0800
Message-ID: <CAJx26kWkL8vzs-fKjmqZmtTxawnQ_QRofRHef+_-N9GPbLtRYg@mail.gmail.com>
Subject: Re: [PATCH] watchdog: Add hardware dependency to BCM7038 driver
From: Justin Chen <justinpopo6@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.de>, linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Feb 22, 2016 at 4:16 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Mon, Feb 22, 2016 at 11:16:30AM -0800, Justin Chen wrote:
>> On Mon, Feb 22, 2016 at 10:43 AM, Jean Delvare <jdelvare@suse.de> wrote:
>> > Hello Justin,
>> >
>> > Le Monday 22 February 2016 à 09:58 -0800, Justin Chen a écrit :
>> >> This driver is based off of a Broadcom watchdog block, it is not tied
>> >> to the MIPS core.
>> >> The watchdog driver is named BCM7038 because that was the first chip
>> >> that featured this watchdog block. Their are other chips that use this
>> >> driver that are not MIPS based.
>> >
>> > The Kconfig help text doesn't say this at all. With the current wording
>> > there is no reason why anyone would enable this option if not building a
>> > kernel for the Broadcom BCM7038.
>> Sorry about that! I can submit a patch to fix this.
>> >
>> > Which other systems reuse this watchdog block exactly? In the kernel
>> > tree I can't see anyone instantiating this device.
>> BRCMSTB chips use this block as well as other BCM chips.
>>
>> "This driver is for a watchdog block contained in all Broadcom Set-top
>> Box chips since BCM7038. BCM7038 was made public during the 2004 CES,
>> and since then, many chips use this watchdog block including some cable
>> modem chips."
>
Hello Guenter,
> That is a bit vague. Can you be more specific ?
>
> Also, while the driver may not be limited to MIPS, I am relatively sure
> that it has some architecture limits. MIPS, ARM, and ARM64, maybe ?
Yes you are correct, this driver would be limited to Broadcom chips. I
would suggest "depends on ARCH_BRCMSTB || BMIPS_GENERIC ||
COMPILE_TEST"
>
> Thanks,
> Guenter

Thanks,
Justin
