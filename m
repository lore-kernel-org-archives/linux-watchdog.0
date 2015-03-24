Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:25647 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbbCXIrx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Mar 2015 04:47:53 -0400
From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	James Hogan <James.Hogan@imgtec.com>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"James Hogan" <james@albanarts.com>,
	Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>,
	Jude Abraham <Jude.Abraham@imgtec.com>
Subject: RE: [PATCH 0/2] watchdog: imgpdc: Runtime fixes
Date: Tue, 24 Mar 2015 08:47:49 +0000
Message-ID: <27E62D98F903554192E3C13AFCC91C3C2FA85881@hbmail01.hb.imgtec.org>
References: <1424475945-30009-1-git-send-email-james.hogan@imgtec.com>,<20150324081944.GB1716@spo001.leaseweb.nl>
In-Reply-To: <20150324081944.GB1716@spo001.leaseweb.nl>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim & James,

> Hi James,

>> A couple of basic runtime fixes for the IMG PDC watchdog driver. These
>> were found by attempting to enable the driver for TZ1090 and running
>> under Meta QEMU. Note that QEMU doesn't emulate the actual watchdog
>> functionality beyond the soft reset register, so I cannot claim to have
>> tested the driver's watchdog timer functionality yet.
>>
>> James Hogan (2):
>>   watchdog: imgpdc: Fix probe NULL pointer dereference
>>   watchdog: imgpdc: Fix default heartbeat
>>
>>  drivers/watchdog/imgpdc_wdt.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> Cc: Wim Van Sebroeck <wim@iguana.be>
>> Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>> Cc: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>> Cc: Jude Abraham <Jude.Abraham@imgtec.com>
>> Cc: linux-watchdog@vger.kernel.org

> Both patches added to linux-watchdog-next. Will go upstream in 2 days.

Many thanks for your help in this regard.

> Kind regards,
> Wim.

Regards,
Naidu.

