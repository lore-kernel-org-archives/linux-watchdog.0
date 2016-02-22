Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54504 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221AbcBVSoA (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Feb 2016 13:44:00 -0500
Subject: Re: [PATCH] watchdog: Add hardware dependency to BCM7038 driver
From: Jean Delvare <jdelvare@suse.de>
To: Justin Chen <justinpopo6@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>
In-Reply-To: <CAJx26kWTo9OEZ-FCPMwE4t+=zZNf5d97sDRTx-FibEf92Tg--w@mail.gmail.com>
References: <20160222121132.665b1f77@endymion>
	 <56CB1FE5.8080206@roeck-us.net>
	 <CAJx26kWTo9OEZ-FCPMwE4t+=zZNf5d97sDRTx-FibEf92Tg--w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 22 Feb 2016 19:43:56 +0100
Message-ID: <1456166636.4629.119.camel@chaos.site>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Justin,

Le Monday 22 February 2016 à 09:58 -0800, Justin Chen a écrit :
> This driver is based off of a Broadcom watchdog block, it is not tied
> to the MIPS core.
> The watchdog driver is named BCM7038 because that was the first chip
> that featured this watchdog block. Their are other chips that use this
> driver that are not MIPS based.

The Kconfig help text doesn't say this at all. With the current wording
there is no reason why anyone would enable this option if not building a
kernel for the Broadcom BCM7038.

Which other systems reuse this watchdog block exactly? In the kernel
tree I can't see anyone instantiating this device.

-- 
Jean Delvare
SUSE L3 Support

