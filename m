Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:47732 "EHLO mail.cosmopool.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbbJDJDQ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 4 Oct 2015 05:03:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Sun, 04 Oct 2015 11:02:56 +0200
From: <harald@ccbib.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	<rtc-linux@googlegroups.com>, <linux-watchdog@vger.kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv2] watchdog: stmp3xxx: Implement GETBOOTSTATUS
In-Reply-To: <CAOMZO5A=dUVUXh+-zYBq6F9FGwk2rRiqS2PXfOLrsAqHKpDyBA@mail.gmail.com>
References: <1443909258-24914-1-git-send-email-harald@ccbib.org> <CAOMZO5A=dUVUXh+-zYBq6F9FGwk2rRiqS2PXfOLrsAqHKpDyBA@mail.gmail.com>
Message-ID: <ad6fdebace028000826ac5823beb082c@imap.cosmopool.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Fabio!

On Sat, 3 Oct 2015 19:13:26 -0300, Fabio Estevam <festevam@gmail.com>
wrote:
> Hi Harald,
> 
> On Sat, Oct 3, 2015 at 6:54 PM, Harald Geyer <harald@ccbib.org> wrote:
>> When the watchdog is enabled, we set a persitent bit. After booting
>> we query the bit and see if the system was reset by the watchdog.
>>
>> This is somewhat similar to what the legacy driver from freescale
>> does. However we use STMP3XXX_RTC_PERSISTENT2 instead of
>> STMP3XXX_RTC_PERSISTENT1. I tried that first, but it seems I can't
>> clear the bit there once it is set. I didn't find any documentation
>> what this register does - only vague hints that it is meant to
>> control the boot ROM.
>>
>> Part of the code from the legacy driver touching this register
>> is still included. Maybe this is stale, but this patch doesn't
>> touch any of it because I don't know what it really does or is
>> meant to do.
>>
>> Signed-off-by: Harald Geyer <harald@ccbib.org>
> 
> I read your commit log, but it is not clear for me what is the real
> issue you are trying to solve with this patch.

The purpose of the patch is to implement the GETBOOTSTATUS ioctl on
this device, so that userspace can check if the last reboot was caused
by the watchdog.

Since I don't completely understand the code I'm modifying, I wrote
the rather lenghty commit message to document what I know:

* The feature this patch implements was already present in the BSP
* Following the implementation of the BSP didn't work for me
  (Maybe it works with some other boot method - I can't tell
   without better documentation. I'm using uboot, not bootlets.)
* Some bits of the code from the BSP are present in the current
  mainline kernel. I don't know if this code is doing anything
  useful.

HTE,
Harald
