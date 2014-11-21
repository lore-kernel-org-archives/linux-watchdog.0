Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:30709 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbaKUFxb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 21 Nov 2014 00:53:31 -0500
From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
To: Andrew Bresticker <abrestic@chromium.org>,
	Jude Abraham <Jude.Abraham@imgtec.com>
CC: "wim@iguana.be" <wim@iguana.be>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>,
	"James Hartley" <James.Hartley@imgtec.com>,
	James Hogan <James.Hogan@imgtec.com>,
	Arul Ramasamy <Arul.Ramasamy@imgtec.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 1/2] watchdog: ImgTec PDC Watchdog Timer Driver
Date: Fri, 21 Nov 2014 05:53:24 +0000
Message-ID: <27E62D98F903554192E3C13AFCC91C3C2F509B54@hbmail01.hb.imgtec.org>
References: <1416488526-22079-1-git-send-email-jude.abraham@imgtec.com>
	<1416488526-22079-2-git-send-email-jude.abraham@imgtec.com>,<CAL1qeaGWK+ok1d48i_wrnLdfALjFCRiPZiwwiYUeBSdNdDkHEw@mail.gmail.com>
In-Reply-To: <CAL1qeaGWK+ok1d48i_wrnLdfALjFCRiPZiwwiYUeBSdNdDkHEw@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Andrew,

Many thanks for the review.

> On Thu, Nov 20, 2014 at 5:02 AM,  <jude.abraham@imgtec.com> wrote:
>> From: Jude Abraham <Jude.Abraham@imgtec.com>
>>
>> This commit adds support for ImgTec PowerDown Controller Watchdog Timer.
>>
>> Signed-off-by: Jude Abraham <Jude.Abraham@imgtec.com>
>> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>

> Reviewed-by: Andrew Bresticker <abrestic@chromium.org>

> Two small comments you may want to fix if you need to re-spin the series though:

Will address following two review comments and submit new Patch set today.

>> +static struct watchdog_info pdc_wdt_info = {
>> +       .options                = WDIOF_SETTIMEOUT |
>> +                                 WDIOF_KEEPALIVEPING |
>> +                                 WDIOF_MAGICCLOSE,
>> +       .identity = "IMG PDC Watchdog",
>> +};

> Inconsistent spacing.

>> +       ret = watchdog_init_timeout(&pdc_wdt->wdt_dev, timeout, &pdev->dev);
>> +       if (ret < 0)
>> +               pdc_wdt->wdt_dev.timeout = pdc_wdt->wdt_dev.max_timeout;

> Maybe print an error here?

Regards,
Naidu.
